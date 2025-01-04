#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == clamp(-(4 * gl_InstanceIndex + 0), -511, 511))
		okCount++;

	if (attr0[1] == clamp(-(4 * gl_InstanceIndex + 1), -511, 511))
		okCount++;

	if (attr0[2] == clamp(-(4 * gl_InstanceIndex + 2), -511, 511))
		okCount++;

	if (attr0[3] == clamp(-(4 * gl_InstanceIndex + 3), -1, 1))
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
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
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
layout(location = 0) in vec2 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

    if (okCount == 2)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(2), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
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
	if (abs(attr0[0] - (4.0 * float(gl_InstanceIndex) + 0.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1] - (4.0 * float(gl_InstanceIndex) + 1.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2] - (4.0 * float(gl_InstanceIndex) + 2.0)) < 0.001000)
		okCount++;

	if (abs(attr0[3] - (4.0 * float(gl_InstanceIndex) + 3.0)) < 0.001000)
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
layout(location = 0) in float16_t attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec4 attr0;
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
layout(location = 0) in mat2 attr0;
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
layout(location = 0) in mat2 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in mat4 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] - (16.0 * float(gl_VertexIndex) + 0.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][1] - (16.0 * float(gl_VertexIndex) + 1.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][2] - (16.0 * float(gl_VertexIndex) + 2.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][3] - (16.0 * float(gl_VertexIndex) + 3.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][0] - (16.0 * float(gl_VertexIndex) + 4.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][1] - (16.0 * float(gl_VertexIndex) + 5.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][2] - (16.0 * float(gl_VertexIndex) + 6.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][3] - (16.0 * float(gl_VertexIndex) + 7.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][0] - (16.0 * float(gl_VertexIndex) + 8.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][1] - (16.0 * float(gl_VertexIndex) + 9.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][2] - (16.0 * float(gl_VertexIndex) + 10.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][3] - (16.0 * float(gl_VertexIndex) + 11.0)) < 0.001000)
		okCount++;

	if (abs(attr0[3][0] - (16.0 * float(gl_VertexIndex) + 12.0)) < 0.001000)
		okCount++;

	if (abs(attr0[3][1] - (16.0 * float(gl_VertexIndex) + 13.0)) < 0.001000)
		okCount++;

	if (abs(attr0[3][2] - (16.0 * float(gl_VertexIndex) + 14.0)) < 0.001000)
		okCount++;

	if (abs(attr0[3][3] - (16.0 * float(gl_VertexIndex) + 15.0)) < 0.001000)
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
layout(location = 0) in dmat2 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] + double(0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[0][1] + double(0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[1][0] + double(0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[1][1] + double(0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < double(0.000010))
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
layout(location = 0) in dmat3 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] + double(0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[0][1] + double(0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[0][2] + double(0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[1][0] + double(0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[1][1] + double(0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[1][2] + double(0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[2][0] + double(0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[2][1] + double(0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < double(0.000010))
		okCount++;

	if (abs(attr0[2][2] + double(0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < double(0.000010))
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
layout(location = 0) in int attr0;
layout(location = 1) in ivec2 attr1;
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

	if (attr1[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(2 * gl_InstanceIndex + 1))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in ivec4 attr1;
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
layout(location = 1) in vec2 attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
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

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 1) in float16_t attr1;
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
layout(location = 0) in int attr0;
layout(location = 1) in f16vec3 attr1;
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
layout(location = 1) in ivec3 attr1;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in f16vec2 attr2;
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
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in uvec4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uvec4 attr1;
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec3 attr2;
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

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec3 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in f16vec4 attr2;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in vec3 attr1;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
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
layout(location = 0) in ivec3 attr0;
layout(location = 1) in f16vec2 attr1;
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
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(location = 1) in uvec4 attr1;
layout(location = 2) in float attr2;
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

	if (abs(attr2 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
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
layout(location = 1) in float attr1;
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
layout(location = 1) in vec4 attr1;
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
layout(location = 0) in uint attr0;
layout(location = 1) in float16_t attr1;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in float attr2;
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

	if (abs(attr2 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
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
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in f16vec4 attr2;
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
layout(location = 0) in vec4 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in mat2 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in mat2 attr2;
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

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat2 attr2;
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
layout(location = 0) in float16_t attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec3 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
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

	if (abs(attr1[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
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
layout(location = 0) in int attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in float16_t attr2;
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
layout(location = 1) in uint attr1;
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

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in vec4 attr1;
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
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uint attr1;
layout(location = 2) in float attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in float attr1;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
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
layout(location = 0) in uint attr0;
layout(location = 1) in vec2 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 1) in vec2 attr1;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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
layout(location = 0) in uvec3 attr0;
layout(location = 1) in f16vec4 attr1;
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
layout(location = 0) in uvec3 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
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
layout(location = 1) in vec4 attr1;
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
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
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
layout(location = 0) in float attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
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
layout(location = 0) in float attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in float16_t attr2;
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
layout(location = 0) in vec4 attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr0[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec4 attr0;
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat2 attr2;
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
layout(location = 0) in vec4 attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat3 attr2;
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
layout(location = 0) in f16vec2 attr0;
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat4 attr2;
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
layout(location = 0) in int attr0;
layout(location = 1) in vec2 attr1;
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
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
layout(location = 1) in f16vec4 attr1;
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
layout(location = 1) in uvec2 attr1;
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
layout(location = 1) in uvec4 attr1;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in mat2 attr2;
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
layout(location = 0) in uvec2 attr0;
layout(location = 1) in vec4 attr1;
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
layout(location = 1) in f16vec2 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in float attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
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
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in vec2 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat3 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in vec3 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
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
layout(location = 2) in mat2 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 3) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 3) in vec2 attr1;
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 2) in ivec3 attr1;
layout(location = 1) in uvec4 attr2;
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

	if (attr2[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == uint(4 * gl_VertexIndex + 3))
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
layout(location = 1) in uvec2 attr2;
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

	if (attr2[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(2 * gl_VertexIndex + 1))
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
layout(location = 0) in ivec2 attr0;
layout(location = 4) in vec2 attr1;
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
layout(location = 4) in f16vec3 attr1;
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(location = 0) in ivec3 attr0;
layout(location = 3) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(location = 0) in ivec4 attr0;
layout(location = 4) in f16vec3 attr1;
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
layout(location = 0) in ivec4 attr0;
layout(location = 5) in f16vec4 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in uint attr0;
layout(location = 2) in uvec2 attr1;
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

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
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
layout(location = 0) in uint attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in f16vec4 attr2;
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
layout(location = 2) in vec3 attr1;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 5) in vec4 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 1) in float16_t attr2;
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
layout(location = 2) in vec3 attr1;
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
layout(location = 3) in f16vec3 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in uvec3 attr0;
layout(location = 5) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 5) in vec4 attr1;
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
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float16_t attr1;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
layout(location = 3) in f16vec2 attr1;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 4) in f16vec4 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
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
layout(location = 0) in vec2 attr0;
layout(location = 5) in f16vec2 attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec2 attr0;
layout(location = 5) in f16vec3 attr1;
layout(location = 1) in mat4 attr2;
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
layout(location = 0) in vec2 attr0;
layout(location = 4) in f16vec4 attr1;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 4) in f16vec2 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
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
layout(location = 0) in vec4 attr0;
layout(location = 5) in mat2 attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 5) in uvec3 attr1;
layout(location = 1) in mat4 attr2;
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
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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
layout(location = 0) in ivec2 attr0;
layout(location = 5) in uint attr1;
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
layout(location = 2) in float attr1;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec3 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 4) in vec3 attr1;
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
layout(location = 4) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 4) in float16_t attr1;
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in vec4 attr2;
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

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 2) in vec2 attr1;
layout(location = 1) in vec4 attr2;
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
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
layout(location = 0) in uvec3 attr0;
layout(location = 5) in f16vec3 attr1;
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
layout(location = 1) in vec3 attr2;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in vec4 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 2) in vec4 attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 4) in f16vec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 5) in f16vec2 attr1;
layout(location = 1) in mat4 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 4) in f16vec3 attr1;
layout(location = 1) in mat3 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 4) in ivec2 attr1;
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

	if (attr1[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(2 * gl_InstanceIndex + 1))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 5) in uint attr1;
layout(location = 1) in mat4 attr2;
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

	if (abs(attr2 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
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
layout(location = 2) in uvec2 attr1;
layout(location = 1) in vec2 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
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
layout(location = 4) in mat2 attr1;
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

	if (abs(attr1[0][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1][1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
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
layout(location = 0) in ivec2 attr0;
layout(location = 4) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec4 attr1;
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
layout(location = 5) in mat2 attr1;
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

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 1) in float attr2;
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

	if (abs(attr2 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
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
layout(location = 2) in vec2 attr1;
layout(location = 1) in f16vec3 attr2;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
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
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
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
layout(location = 3) in vec3 attr1;
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

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
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
layout(location = 0) in ivec4 attr0;
layout(location = 3) in f16vec3 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
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

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in vec4 attr2;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 2) in uvec4 attr1;
layout(location = 1) in vec2 attr2;
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

	if (abs(attr2[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in f16vec4 attr2;
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
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec3 attr2;
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
layout(location = 0) in float16_t attr0;
layout(location = 5) in f16vec3 attr1;
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
layout(location = 0) in f16vec4 attr0;
layout(location = 5) in mat2 attr1;
layout(location = 1) in mat4 attr2;
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
layout(location = 0) in int attr0;
layout(location = 2) in ivec2 attr1;
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

	if (attr1[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(2 * gl_InstanceIndex + 1))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
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
layout(location = 0) in int attr0;
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 2) in vec4 attr1;
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
layout(location = 2) in ivec4 attr1;
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec2 attr2;
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

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
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
layout(location = 2) in float16_t attr1;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in uvec3 attr2;
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

	if (attr2[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(3 * gl_VertexIndex + 2))
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
layout(location = 2) in uint attr1;
layout(location = 4) in vec3 attr2;
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
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
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
layout(location = 2) in float16_t attr1;
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

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
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
layout(location = 0) in uint attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec4 attr2;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec4 attr1;
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in f16vec3 attr1;
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in uvec4 attr1;
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
layout(location = 2) in f16vec2 attr1;
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
layout(location = 0) in uvec3 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec3 attr1;
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
layout(location = 2) in float16_t attr1;
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
layout(location = 0) in float attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in f16vec4 attr2;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
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
	if (abs(attr0[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr0[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
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
layout(location = 0) in f16vec2 attr0;
layout(location = 2) in f16vec4 attr1;
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
layout(location = 2) in f16vec4 attr1;
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
layout(location = 0) in int attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
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
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec4 attr1;
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

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
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
layout(location = 2) in vec3 attr1;
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
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
layout(location = 2) in vec3 attr1;
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
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
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
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
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

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float attr1;
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
layout(location = 2) in vec3 attr1;
layout(location = 4) in f16vec3 attr2;
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
layout(location = 0) in float attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
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
layout(location = 0) in vec2 attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat2 attr2;
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
	if (abs(attr0[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in mat2 attr0;
layout(location = 3) in mat3 attr1;
layout(location = 7) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr0[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr0[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr0[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
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
layout(location = 0) in int attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 4) in float attr2;
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

	if (abs(attr2 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
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
layout(location = 2) in ivec4 attr1;
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

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
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
layout(location = 2) in uvec2 attr1;
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
layout(location = 2) in float attr1;
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
layout(location = 2) in float attr1;
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

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in float attr1;
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

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
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
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec2 attr1;
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
layout(location = 2) in vec3 attr1;
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
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uvec3 attr1;
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

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
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
layout(location = 2) in vec2 attr1;
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

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
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
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
layout(location = 4) in vec3 attr2;
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

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
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
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec3 attr1;
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

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in f16vec3 attr1;
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

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
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
layout(location = 2) in float16_t attr1;
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
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec4 attr1;
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

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
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
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat4 attr2;
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
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
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
layout(location = 0) in vec2 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in f16vec4 attr2;
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
	if (abs(attr0[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr0[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
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
layout(location = 0) in vec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec3 attr2;
layout(location = 3) in f16vec4 attr3;
layout(location = 4) in uvec3 attr4;
layout(location = 5) in ivec4 attr5;
layout(location = 6) in uvec3 attr6;
layout(location = 7) in uvec4 attr7;
layout(location = 8) in uvec4 attr8;
layout(location = 9) in vec4 attr9;
layout(location = 10) in f16vec3 attr10;
layout(location = 11) in ivec3 attr11;
layout(location = 12) in f16vec4 attr12;
layout(location = 13) in vec3 attr13;
layout(location = 14) in vec3 attr14;
layout(location = 15) in f16vec3 attr15;
layout(location = 16) in float attr16;
layout(location = 17) in uint attr17;
layout(location = 18) in f16vec2 attr18;
layout(location = 19) in float attr19;
layout(location = 20) in uvec2 attr20;
layout(location = 21) in f16vec4 attr21;
layout(location = 22) in f16vec4 attr22;
layout(location = 23) in vec3 attr23;
layout(location = 24) in uvec4 attr24;
layout(location = 25) in vec2 attr25;
layout(location = 26) in uvec3 attr26;
layout(location = 27) in uvec3 attr27;
layout(location = 28) in uvec4 attr28;
layout(location = 29) in ivec2 attr29;
layout(location = 30) in f16vec2 attr30;
layout(location = 31) in vec3 attr31;
layout(location = 32) in vec2 attr32;
layout(location = 33) in f16vec2 attr33;
layout(location = 34) in uvec2 attr34;
layout(location = 35) in ivec4 attr35;
layout(location = 36) in ivec4 attr36;
layout(location = 37) in uint attr37;
layout(location = 38) in f16vec3 attr38;
layout(location = 39) in ivec4 attr39;
layout(location = 40) in uvec2 attr40;
layout(location = 41) in ivec3 attr41;
layout(location = 42) in ivec4 attr42;
layout(location = 43) in vec3 attr43;
layout(location = 44) in uvec3 attr44;
layout(location = 45) in f16vec4 attr45;
layout(location = 46) in vec2 attr46;
layout(location = 47) in uint attr47;
layout(location = 48) in ivec2 attr48;
layout(location = 49) in vec4 attr49;
layout(location = 50) in vec4 attr50;
layout(location = 51) in ivec2 attr51;
layout(location = 52) in uvec3 attr52;
layout(location = 53) in vec4 attr53;
layout(location = 54) in f16vec2 attr54;
layout(location = 55) in ivec4 attr55;
layout(location = 56) in float attr56;
layout(location = 57) in uvec2 attr57;
layout(location = 58) in uvec2 attr58;
layout(location = 59) in uvec4 attr59;
layout(location = 60) in uvec4 attr60;
layout(location = 61) in ivec2 attr61;
layout(location = 62) in float16_t attr62;
layout(location = 63) in float16_t attr63;
layout(location = 64) in ivec4 attr64;
layout(location = 65) in ivec3 attr65;
layout(location = 66) in vec2 attr66;
layout(location = 67) in f16vec2 attr67;
layout(location = 68) in uvec4 attr68;
layout(location = 69) in uvec2 attr69;
layout(location = 70) in ivec3 attr70;
layout(location = 71) in ivec3 attr71;
layout(location = 72) in vec2 attr72;
layout(location = 73) in vec2 attr73;
layout(location = 74) in int attr74;
layout(location = 75) in uvec2 attr75;
layout(location = 76) in ivec3 attr76;
layout(location = 77) in ivec4 attr77;
layout(location = 78) in ivec2 attr78;
layout(location = 79) in float16_t attr79;
layout(location = 80) in vec4 attr80;
layout(location = 81) in uvec3 attr81;
layout(location = 82) in uvec3 attr82;
layout(location = 83) in uvec3 attr83;
layout(location = 84) in uvec4 attr84;
layout(location = 85) in vec4 attr85;
layout(location = 86) in f16vec4 attr86;
layout(location = 87) in uvec3 attr87;
layout(location = 88) in vec4 attr88;
layout(location = 89) in vec3 attr89;
layout(location = 90) in f16vec4 attr90;
layout(location = 91) in ivec3 attr91;
layout(location = 92) in float attr92;
layout(location = 93) in uvec4 attr93;
layout(location = 94) in f16vec2 attr94;
layout(location = 95) in f16vec3 attr95;
layout(location = 96) in f16vec4 attr96;
layout(location = 97) in ivec2 attr97;
layout(location = 98) in float attr98;
layout(location = 99) in vec4 attr99;
layout(location = 100) in uvec3 attr100;
layout(location = 101) in uvec3 attr101;
layout(location = 102) in f16vec3 attr102;
layout(location = 103) in f16vec2 attr103;
layout(location = 104) in ivec4 attr104;
layout(location = 105) in vec2 attr105;
layout(location = 106) in ivec3 attr106;
layout(location = 107) in uvec2 attr107;
layout(location = 108) in ivec4 attr108;
layout(location = 109) in ivec3 attr109;
layout(location = 110) in ivec4 attr110;
layout(location = 111) in f16vec4 attr111;
layout(location = 112) in int attr112;
layout(location = 113) in uvec3 attr113;
layout(location = 114) in vec4 attr114;
layout(location = 115) in uvec4 attr115;
layout(location = 116) in f16vec2 attr116;
layout(location = 117) in uvec3 attr117;
layout(location = 118) in uvec4 attr118;
layout(location = 119) in vec2 attr119;
layout(location = 120) in vec3 attr120;
layout(location = 121) in vec4 attr121;
layout(location = 122) in uvec2 attr122;
layout(location = 123) in ivec3 attr123;
layout(location = 124) in uvec2 attr124;
layout(location = 125) in float16_t attr125;
layout(location = 126) in ivec4 attr126;
layout(location = 127) in float16_t attr127;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr0[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr3[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr3[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr3[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr3[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr4[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr4[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr4[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr5[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr5[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr5[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr5[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr6[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr6[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr6[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr7[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr7[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr7[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr7[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr8[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr8[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr8[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr8[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr9[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr9[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr9[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr9[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr10[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr10[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr10[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr11[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr11[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr11[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr12[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr12[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr12[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr12[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr13[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr13[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr13[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr14[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr14[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr14[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr15[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr16 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (attr17 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr18[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr18[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr19 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (attr20[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr20[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr21[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr21[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr21[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr21[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr23[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr23[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr23[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (attr24[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr24[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr24[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr24[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr25[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr25[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (attr26[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr26[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr26[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr27[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr27[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr27[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr28[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr28[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr28[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr28[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr29[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr29[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr30[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr30[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr31[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr31[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr31[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr32[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr32[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr33[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr33[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr34[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr34[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (attr35[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr35[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr35[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr35[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr36[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr36[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr36[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr36[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr37 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr38[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr38[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr38[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr39[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr39[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr39[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr39[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr40[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr40[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (attr41[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr41[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr41[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr42[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr42[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr42[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr42[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr43[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr43[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr43[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (attr44[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr44[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr44[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr45[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr45[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr45[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr45[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr46[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr46[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (attr47 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr48[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr48[1] == -(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr49[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr49[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr49[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr49[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr50[0] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr50[1] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr50[2] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr50[3] - (-1.0 + 0.000031 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
		okCount++;

	if (attr51[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr51[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr52[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr52[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr52[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr53[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr53[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr53[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr53[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr54[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr54[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr55[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr55[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr55[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr55[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr56 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (attr57[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr57[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr58[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr58[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (attr59[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr59[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr59[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr59[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr60[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr60[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr60[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr60[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr61[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr61[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr62 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr63 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr64[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr64[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr64[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr64[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr65[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr65[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr65[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr66[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr66[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr67[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr67[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr68[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr68[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr68[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr68[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr69[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr69[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr70[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr70[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr70[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr71[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr71[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr71[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr72[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr72[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr73[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr73[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (attr74 == -(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr75[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr75[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr76[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr76[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr76[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr77[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr77[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr77[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr77[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr78[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr78[1] == -(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr79 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr80[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr80[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr80[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr80[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (attr81[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr81[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr81[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr82[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr82[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr82[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr83[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr83[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr83[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr84[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr84[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr84[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr84[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr85[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr85[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr85[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr85[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr86[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr86[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr86[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr86[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr87[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr87[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr87[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr88[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr88[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr88[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr88[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr89[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr89[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr89[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr90[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr90[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr90[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr90[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr91[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr91[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr91[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr92 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (attr93[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr93[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr93[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr93[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr94[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr94[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr95[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr95[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr95[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr96[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr96[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr96[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr96[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr97[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr97[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr98 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr99[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr99[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr99[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr99[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (attr100[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr100[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr100[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr101[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr101[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr101[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr102[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr102[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr102[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr103[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr103[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr104[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr104[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr104[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr104[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr105[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr105[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (attr106[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr106[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr106[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr107[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr107[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr108[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr108[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr108[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr108[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr109[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr109[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr109[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr110[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr110[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr110[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr110[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr111[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr111[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr111[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr111[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr112 == -(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr113[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr113[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr113[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr114[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr114[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr114[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr114[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (attr115[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr115[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr115[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr115[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr116[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr116[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr117[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr117[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr117[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr118[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr118[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr118[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr118[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr119[0] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr119[1] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr120[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr120[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr120[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr121[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr121[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr121[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr121[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (attr122[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr122[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (attr123[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr123[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr123[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr124[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr124[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr125 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr126[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr126[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr126[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr126[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr127 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 363)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(363), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
