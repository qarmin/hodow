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
	if (abs(attr0[0][0] - (9.0 * float(gl_InstanceIndex) + 0.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][1] - (9.0 * float(gl_InstanceIndex) + 1.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][2] - (9.0 * float(gl_InstanceIndex) + 2.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][0] - (9.0 * float(gl_InstanceIndex) + 3.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][1] - (9.0 * float(gl_InstanceIndex) + 4.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][2] - (9.0 * float(gl_InstanceIndex) + 5.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][0] - (9.0 * float(gl_InstanceIndex) + 6.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][1] - (9.0 * float(gl_InstanceIndex) + 7.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][2] - (9.0 * float(gl_InstanceIndex) + 8.0)) < 0.001000)
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
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
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
	if (abs(attr0[0][0] - (0.003922 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[0][1] - (0.003922 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr0[0][2] - (0.003922 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1][0] - (0.003922 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1][1] - (0.003922 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1][2] - (0.003922 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2][0] - (0.003922 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2][1] - (0.003922 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2][2] - (0.003922 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
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
	if (abs(attr0[0][0] - (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < (0.008000))
		okCount++;

	if (abs(attr0[0][1] - (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < (0.008000))
		okCount++;

	if (abs(attr0[0][2] - (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < (0.008000))
		okCount++;

	if (abs(attr0[1][0] - (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < (0.008000))
		okCount++;

	if (abs(attr0[1][1] - (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < (0.008000))
		okCount++;

	if (abs(attr0[1][2] - (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < (0.008000))
		okCount++;

	if (abs(attr0[2][0] - (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < (0.008000))
		okCount++;

	if (abs(attr0[2][1] - (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < (0.008000))
		okCount++;

	if (abs(attr0[2][2] - (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < (0.008000))
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
	if (abs(attr0[0][0] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 0.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[0][1] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 1.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[0][2] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 2.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[0][3] - clamp((0.333333 * (16.0 * float(gl_InstanceIndex) + 3.0)), 0.0, 1.0)) < 0.500000)
		okCount++;

	if (abs(attr0[1][0] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 4.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[1][1] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 5.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[1][2] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 6.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[1][3] - clamp((0.333333 * (16.0 * float(gl_InstanceIndex) + 7.0)), 0.0, 1.0)) < 0.500000)
		okCount++;

	if (abs(attr0[2][0] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 8.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[2][1] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 9.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[2][2] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 10.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[2][3] - clamp((0.333333 * (16.0 * float(gl_InstanceIndex) + 11.0)), 0.0, 1.0)) < 0.500000)
		okCount++;

	if (abs(attr0[3][0] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 12.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[3][1] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 13.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[3][2] - clamp((0.000978 * (16.0 * float(gl_InstanceIndex) + 14.0)), 0.0, 1.0)) < 0.001466)
		okCount++;

	if (abs(attr0[3][3] - clamp((0.333333 * (16.0 * float(gl_InstanceIndex) + 15.0)), 0.0, 1.0)) < 0.500000)
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
layout(location = 2) in mat2 attr2;
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

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in int attr0;
layout(location = 1) in uint attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 1) in uvec3 attr1;
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

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
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
layout(location = 1) in float attr1;
layout(location = 2) in vec4 attr2;
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
layout(location = 0) in int attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
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
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
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
layout(location = 0) in int attr0;
layout(location = 1) in vec4 attr1;
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

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uint attr1;
layout(location = 2) in mat4 attr2;
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in float16_t attr2;
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

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec2 attr1;
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

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in vec4 attr1;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in f16vec3 attr2;
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in f16vec4 attr1;
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
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in uvec4 attr2;
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

	if (attr2[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == uint(4 * gl_VertexIndex + 3))
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
layout(location = 1) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
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
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec3 attr2;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
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
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat4 attr2;
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

	if (abs(attr1[0][0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
layout(location = 0) in uint attr0;
layout(location = 1) in uvec2 attr1;
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
layout(location = 1) in uvec3 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in uint attr0;
layout(location = 1) in float16_t attr1;
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
layout(location = 1) in float16_t attr1;
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
layout(location = 1) in uvec4 attr1;
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
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec3 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
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
layout(location = 1) in uvec4 attr1;
layout(location = 2) in float16_t attr2;
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
layout(location = 0) in uvec3 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in float16_t attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec3 attr2;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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
layout(location = 0) in uvec3 attr0;
layout(location = 1) in vec3 attr1;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
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
layout(location = 0) in uvec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec2 attr2;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in uvec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in mat2 attr2;
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
layout(location = 0) in uvec4 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec2 attr2;
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

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 1) in vec2 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec3 attr2;
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

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec4 attr2;
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

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in vec3 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in mat2 attr2;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in vec3 attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat3 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec2 attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in mat2 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 5) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000010)
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
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in vec2 attr2;
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
layout(location = 0) in ivec2 attr0;
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat4 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 1) in uint attr1;
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

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
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
layout(location = 1) in uint attr1;
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

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec3 attr1;
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
layout(location = 0) in ivec4 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in float16_t attr2;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
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
layout(location = 0) in ivec4 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec2 attr2;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in uint attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec3 attr1;
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

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in f16vec3 attr1;
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
layout(location = 0) in uvec3 attr0;
layout(location = 1) in f16vec2 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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

	if (abs(attr1[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
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
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 0) in float attr0;
layout(location = 1) in mat3 attr1;
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
layout(location = 1) in vec4 attr1;
layout(location = 2) in f16vec3 attr2;
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

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in f16vec3 attr2;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec4 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr0[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr0[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in ivec2 attr1;
layout(location = 2) in float attr2;
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

	if (abs(attr2 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 1) in ivec2 attr1;
layout(location = 2) in vec4 attr2;
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

	if (abs(attr2[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
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
layout(location = 1) in ivec4 attr1;
layout(location = 2) in vec3 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in int attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in vec3 attr2;
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
layout(location = 0) in int attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
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
layout(location = 0) in int attr0;
layout(location = 1) in vec3 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in int attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in vec2 attr2;
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

	if (abs(attr2[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
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
layout(location = 1) in vec2 attr1;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 1) in uvec3 attr1;
layout(location = 2) in vec2 attr2;
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

	if (abs(attr2[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
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
layout(location = 1) in float attr1;
layout(location = 2) in vec2 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
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
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec3 attr2;
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in vec4 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in uint attr0;
layout(location = 1) in mat3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in vec3 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in float attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
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
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 1) in f16vec4 attr1;
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 0) in float16_t attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in f16vec3 attr0;
layout(location = 1) in mat3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000010)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec2 attr1;
layout(location = 1) in ivec4 attr2;
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

	if (attr2[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == -(4 * gl_VertexIndex + 3))
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
layout(location = 2) in ivec3 attr1;
layout(location = 1) in ivec4 attr2;
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

	if (attr2[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == -(4 * gl_VertexIndex + 3))
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
layout(location = 2) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
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
layout(location = 2) in uvec2 attr1;
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
layout(location = 2) in uvec3 attr1;
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
layout(location = 2) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
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
layout(location = 2) in ivec4 attr1;
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
layout(location = 2) in vec3 attr1;
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
layout(location = 2) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 1) in vec3 attr2;
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 2) in vec4 attr1;
layout(location = 1) in f16vec2 attr2;
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
layout(location = 2) in uint attr1;
layout(location = 1) in vec4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 1) in vec4 attr2;
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
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in vec4 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in ivec4 attr0;
layout(location = 4) in float attr1;
layout(location = 1) in mat3 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec4 attr1;
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

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec4 attr1;
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
layout(location = 0) in uint attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 1) in vec2 attr2;
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

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
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
layout(location = 2) in float attr1;
layout(location = 1) in float16_t attr2;
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
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
layout(location = 1) in f16vec2 attr2;
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
layout(location = 3) in f16vec2 attr1;
layout(location = 1) in mat2 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 0) in uint attr0;
layout(location = 5) in mat2 attr1;
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

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec3 attr1;
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

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(location = 0) in uvec2 attr0;
layout(location = 4) in vec3 attr1;
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec3 attr2;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 5) in f16vec4 attr1;
layout(location = 1) in mat4 attr2;
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
layout(location = 5) in float attr1;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in uvec3 attr0;
layout(location = 5) in vec2 attr1;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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
layout(location = 2) in vec3 attr1;
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

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
layout(location = 0) in uvec4 attr0;
layout(location = 5) in mat3 attr1;
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
layout(location = 0) in float attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in float16_t attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
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
layout(location = 4) in float16_t attr1;
layout(location = 1) in mat3 attr2;
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
layout(location = 0) in vec3 attr0;
layout(location = 5) in f16vec2 attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in f16vec2 attr0;
layout(location = 3) in f16vec4 attr1;
layout(location = 1) in mat2 attr2;
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

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
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
layout(location = 5) in uvec2 attr1;
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in float attr2;
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

	if (abs(attr2 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
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
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 0) in uvec2 attr0;
layout(location = 3) in vec4 attr1;
layout(location = 1) in mat2 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
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
layout(location = 0) in uvec4 attr0;
layout(location = 5) in f16vec2 attr1;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
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
layout(location = 0) in vec3 attr0;
layout(location = 4) in float16_t attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr0[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec3 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
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

	if (abs(attr1[0][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 5) in f16vec4 attr1;
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
layout(location = 5) in mat2 attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec3 attr0;
layout(location = 3) in f16vec4 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in int attr0;
layout(location = 4) in ivec4 attr1;
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
layout(location = 0) in int attr0;
layout(location = 2) in vec3 attr1;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 1) in float attr2;
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

	if (abs(attr2 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 3) in vec3 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 5) in vec4 attr1;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 4) in f16vec2 attr1;
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
layout(location = 0) in ivec4 attr0;
layout(location = 3) in uvec2 attr1;
layout(location = 1) in mat2 attr2;
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

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 3) in vec3 attr1;
layout(location = 1) in mat2 attr2;
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

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in uvec2 attr0;
layout(location = 5) in mat2 attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 4) in vec2 attr1;
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in vec2 attr2;
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

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
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
layout(location = 2) in vec4 attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(location = 0) in uvec4 attr0;
layout(location = 4) in f16vec3 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 3) in float16_t attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 0) in vec3 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec3 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 0) in int attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
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
layout(location = 2) in vec3 attr1;
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
layout(location = 0) in int attr0;
layout(location = 2) in vec4 attr1;
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in ivec3 attr1;
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

	if (attr1[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(3 * gl_InstanceIndex + 2))
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 2) in vec2 attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
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
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec2 attr2;
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

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 4) in f16vec2 attr2;
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

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec4 attr2;
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

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
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
layout(location = 2) in float16_t attr1;
layout(location = 4) in mat3 attr2;
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
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat4 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
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
layout(location = 2) in uint attr1;
layout(location = 4) in float attr2;
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

	if (abs(attr2 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in f16vec3 attr2;
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
layout(location = 2) in uvec2 attr1;
layout(location = 4) in vec2 attr2;
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

	if (abs(attr2[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
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
layout(location = 2) in uvec4 attr1;
layout(location = 4) in mat3 attr2;
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
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec4 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 2) in uvec2 attr1;
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
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
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
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in uint attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in mat3 attr2;
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec4 attr2;
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in f16vec3 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec4 attr2;
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

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat2 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
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
layout(location = 2) in float16_t attr1;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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

    if (okCount == 18)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(18), 0.0f, 0.0f, 1.0);
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
layout(location = 4) in mat3 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec3 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in mat4 attr2;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat2 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec4 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr0[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr0[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
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
layout(location = 0) in vec4 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in mat4 attr2;
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
layout(location = 0) in vec4 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in f16vec4 attr2;
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
layout(location = 0) in float16_t attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec2 attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
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

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in f16vec4 attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in int attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 2) in float attr1;
layout(location = 4) in f16vec4 attr2;
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
layout(location = 2) in uvec3 attr1;
layout(location = 4) in mat3 attr2;
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec4 attr1;
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

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in f16vec4 attr2;
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in mat2 attr2;
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

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
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
layout(location = 4) in mat2 attr2;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
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
	if (abs(attr0[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr0[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat4 attr2;
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

	if (abs(attr1[0][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in int attr0;
layout(location = 2) in vec4 attr1;
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
layout(location = 2) in uvec2 attr1;
layout(location = 4) in vec2 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr2[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
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
layout(location = 2) in uvec2 attr1;
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

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
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
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec2 attr2;
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

	if (abs(attr2[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
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
layout(location = 2) in uvec3 attr1;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in uvec2 attr1;
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

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in f16vec4 attr2;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in float16_t attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in f16vec4 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
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
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
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

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
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
layout(location = 0) in float attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in float attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
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
layout(location = 2) in f16vec2 attr1;
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
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec2 attr2;
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat4 attr2;
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

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
layout(location = 0) in vec3 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr0[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec4 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000010)
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in ivec2 attr2;
layout(location = 3) in uint attr3;
layout(location = 4) in ivec2 attr4;
layout(location = 5) in ivec4 attr5;
layout(location = 6) in vec2 attr6;
layout(location = 7) in uvec3 attr7;
layout(location = 8) in ivec3 attr8;
layout(location = 9) in uvec2 attr9;
layout(location = 10) in vec2 attr10;
layout(location = 11) in f16vec4 attr11;
layout(location = 12) in uvec3 attr12;
layout(location = 13) in ivec4 attr13;
layout(location = 14) in vec3 attr14;
layout(location = 15) in f16vec4 attr15;
layout(location = 16) in ivec4 attr16;
layout(location = 17) in uint attr17;
layout(location = 18) in uvec4 attr18;
layout(location = 19) in uvec4 attr19;
layout(location = 20) in uint attr20;
layout(location = 21) in f16vec2 attr21;
layout(location = 22) in vec3 attr22;
layout(location = 23) in vec4 attr23;
layout(location = 24) in vec4 attr24;
layout(location = 25) in vec4 attr25;
layout(location = 26) in float attr26;
layout(location = 27) in uvec4 attr27;
layout(location = 28) in f16vec4 attr28;
layout(location = 29) in float attr29;
layout(location = 30) in int attr30;
layout(location = 31) in f16vec2 attr31;
layout(location = 32) in f16vec4 attr32;
layout(location = 33) in float16_t attr33;
layout(location = 34) in ivec2 attr34;
layout(location = 35) in uvec3 attr35;
layout(location = 36) in vec3 attr36;
layout(location = 37) in vec4 attr37;
layout(location = 38) in ivec4 attr38;
layout(location = 39) in vec4 attr39;
layout(location = 40) in uvec4 attr40;
layout(location = 41) in uvec4 attr41;
layout(location = 42) in uvec4 attr42;
layout(location = 43) in ivec3 attr43;
layout(location = 44) in vec4 attr44;
layout(location = 45) in vec3 attr45;
layout(location = 46) in ivec3 attr46;
layout(location = 47) in vec2 attr47;
layout(location = 48) in float attr48;
layout(location = 49) in vec2 attr49;
layout(location = 50) in float16_t attr50;
layout(location = 51) in ivec3 attr51;
layout(location = 52) in vec2 attr52;
layout(location = 53) in vec2 attr53;
layout(location = 54) in uvec2 attr54;
layout(location = 55) in ivec3 attr55;
layout(location = 56) in vec4 attr56;
layout(location = 57) in vec2 attr57;
layout(location = 58) in ivec2 attr58;
layout(location = 59) in float16_t attr59;
layout(location = 60) in uvec3 attr60;
layout(location = 61) in uvec3 attr61;
layout(location = 62) in uvec2 attr62;
layout(location = 63) in float16_t attr63;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (attr2[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr3 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr4[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr4[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr5[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr5[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr5[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr5[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr6[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr6[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (attr7[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr7[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr7[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr8[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr8[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr8[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr9[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr9[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr10[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr10[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr11[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr11[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr11[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr11[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr12[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr12[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr12[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr13[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr13[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr13[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr13[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr14[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr14[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr14[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr15[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr16[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr16[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr16[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr16[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr17 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr18[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr18[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr18[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr18[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr19[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr19[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr19[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr19[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr20 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr21[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr21[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr22[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr22[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr23[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr23[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr23[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr23[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr24[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr24[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr24[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr24[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr25[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr25[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr25[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr25[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr26 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (attr27[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr27[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr27[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr27[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr28[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr28[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr28[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr28[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr29 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (attr30 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr31[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr31[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr32[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr32[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr32[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr32[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr33 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr34[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr34[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr35[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr35[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr35[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr36[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr36[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr36[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr37[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr37[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr37[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr37[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (attr38[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr38[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr38[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr38[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr39[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr39[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr39[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr39[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (attr40[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr40[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr40[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr40[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr41[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr41[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr41[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr41[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr42[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr42[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr42[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr42[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr43[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr43[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr43[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr44[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr44[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr44[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr44[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr45[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr45[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr45[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (attr46[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr46[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr46[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr47[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr47[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr48 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr49[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr49[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr50 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr51[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr51[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr51[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr52[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr52[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr53[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr53[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (attr54[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr54[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr55[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr55[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr55[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr56[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr56[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr56[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr56[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr57[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr57[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (attr58[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr58[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr59 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr60[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr60[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr60[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr61[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr61[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr61[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr62[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr62[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr63 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 173)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(173), 0.0f, 0.0f, 1.0);
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
