#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
    gl_PointSize = 1.0;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex;
    gl_PointSize = 1.0f;
}
#version 450

layout(push_constant) uniform pushConstants
{
    uint start;
} uInput;

layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint idx_out;

void main(void)
{
    idx_out = uInput.start + gl_VertexIndex * 2u;
    gl_PointSize = 1.0f;
}
#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
float gl_PointSize;
};

void main(void)
{
gl_PointSize = float(gl_VertexIndex) / 32768.0f;
}
#version 450

layout(xfb_buffer = 1, xfb_offset = 0) out gl_PerVertex
{
float gl_PointSize;
};

void main(void)
{
gl_PointSize = float(gl_VertexIndex) / 32768.0f;
}
#version 450

layout(xfb_buffer = 3, xfb_offset = 0) out gl_PerVertex
{
float gl_PointSize;
};

void main(void)
{
gl_PointSize = float(gl_VertexIndex) / 32768.0f;
}
#version 450

layout(xfb_buffer = 7, xfb_offset = 0) out gl_PerVertex
{
float gl_PointSize;
};

void main(void)
{
gl_PointSize = float(gl_VertexIndex) / 32768.0f;
}
#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
float gl_ClipDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_ClipDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 1, xfb_offset = 0) out gl_PerVertex
{
float gl_ClipDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_ClipDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 3, xfb_offset = 0) out gl_PerVertex
{
float gl_ClipDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_ClipDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 7, xfb_offset = 0) out gl_PerVertex
{
float gl_ClipDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_ClipDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_CullDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 1, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_CullDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 3, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_CullDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 7, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[7];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<7; i++) gl_CullDistance[i] = float(8 * gl_VertexIndex + i) / 32768.0f;
}
#version 450

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[4];
float gl_ClipDistance[1];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<4; i++) gl_CullDistance[i] = float(6 * gl_VertexIndex + i) / 32768.0f;
gl_ClipDistance[0] = float(6 * gl_VertexIndex + 4) / 32768.0f;
}
#version 450

layout(xfb_buffer = 1, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[4];
float gl_ClipDistance[1];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<4; i++) gl_CullDistance[i] = float(6 * gl_VertexIndex + i) / 32768.0f;
gl_ClipDistance[0] = float(6 * gl_VertexIndex + 4) / 32768.0f;
}
#version 450

layout(xfb_buffer = 3, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[4];
float gl_ClipDistance[1];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<4; i++) gl_CullDistance[i] = float(6 * gl_VertexIndex + i) / 32768.0f;
gl_ClipDistance[0] = float(6 * gl_VertexIndex + 4) / 32768.0f;
}
#version 450

layout(xfb_buffer = 7, xfb_offset = 0) out gl_PerVertex
{
float gl_CullDistance[4];
float gl_ClipDistance[1];
float gl_PointSize;
};

void main(void)
{
gl_PointSize = 1.0;
for (int i=0; i<4; i++) gl_CullDistance[i] = float(6 * gl_VertexIndex + i) / 32768.0f;
gl_ClipDistance[0] = float(6 * gl_VertexIndex + 4) / 32768.0f;
}
#version 460
layout (location = 0) in vec4 inPos;

layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 0) flat out float goku;
layout (location = 0, component = 1) flat out float trunks;
layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 8, component = 2) flat out float vegeta;

layout (push_constant, std430) uniform PushConstantBlock {
    vec3 values;
} pc;

void main ()
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

    goku   = pc.values.x;
    trunks = pc.values.y;
    vegeta = pc.values.z;
}
#version 460
layout (location=0) out vec4 outColor;

layout (location = 0) in float goku;
layout (location = 0, component = 1) in float trunks;
layout (location = 0, component = 2) in float vegeta;

void main ()
{
    outColor = ((goku == 10.0 && trunks == 20.0 && vegeta == 30.0)
             ? vec4(0.0, 0.0, 1.0, 1.0)
             : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
layout (location = 0) in vec4 inPos;



void main ()
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

}
#version 460
layout (points) in;
layout (max_vertices=1, points) out;

layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 0) flat out float goku;
layout (location = 0, component = 1) flat out float trunks;
layout (location = 0, xfb_buffer = 0, xfb_stride = 12, xfb_offset = 8, component = 2) flat out float vegeta;

layout (push_constant, std430) uniform PushConstantBlock {
    vec3 values;
} pc;

void main ()
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

    goku   = pc.values.x;
    trunks = pc.values.y;
    vegeta = pc.values.z;

    EmitVertex();
}
#version 460

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0, component=0, xfb_buffer=0, xfb_offset=28) out float part0_0;
layout (location=0, component=1, xfb_buffer=0, xfb_offset=24) out float part0_1;
layout (location=0, component=2, xfb_buffer=0, xfb_offset=20) out float part0_2;
layout (location=0, component=3, xfb_buffer=0, xfb_offset=16) out float part0_3;
layout (location=1, component=0, xfb_buffer=0, xfb_offset=44) out float part1_0;
layout (location=1, component=1, xfb_buffer=0, xfb_offset=40) out float part1_1;
layout (location=1, component=2, xfb_buffer=0, xfb_offset=36) out float part1_2;
layout (location=1, component=3, xfb_buffer=0, xfb_offset=32) out float part1_3;
layout (location=2, component=0, xfb_buffer=0, xfb_offset=60) out float part2_0;
layout (location=2, component=1, xfb_buffer=0, xfb_offset=56) out float part2_1;
layout (location=2, component=2, xfb_buffer=0, xfb_offset=52) out float part2_2;
layout (location=2, component=3, xfb_buffer=0, xfb_offset=48) out float part2_3;
layout (location=3, component=0, xfb_buffer=0, xfb_offset=76) out float part3_0;
layout (location=3, component=1, xfb_buffer=0, xfb_offset=72) out float part3_1;
layout (location=3, component=2, xfb_buffer=0, xfb_offset=68) out float part3_2;
layout (location=3, component=3, xfb_buffer=0, xfb_offset=64) out float part3_3;
layout (location=4, component=0, xfb_buffer=0, xfb_offset=92) out float part4_0;
layout (location=4, component=1, xfb_buffer=0, xfb_offset=88) out float part4_1;
layout (location=4, component=2, xfb_buffer=0, xfb_offset=84) out float part4_2;
layout (location=4, component=3, xfb_buffer=0, xfb_offset=80) out float part4_3;
layout (location=5, component=0, xfb_buffer=0, xfb_offset=108) out float part5_0;
layout (location=5, component=1, xfb_buffer=0, xfb_offset=104) out float part5_1;
layout (location=5, component=2, xfb_buffer=0, xfb_offset=100) out float part5_2;
layout (location=5, component=3, xfb_buffer=0, xfb_offset=96) out float part5_3;
layout (location=6, component=0, xfb_buffer=0, xfb_offset=124) out float part6_0;
layout (location=6, component=1, xfb_buffer=0, xfb_offset=120) out float part6_1;
layout (location=6, component=2, xfb_buffer=0, xfb_offset=116) out float part6_2;
layout (location=6, component=3, xfb_buffer=0, xfb_offset=112) out float part6_3;
layout (location=7, component=0, xfb_buffer=0, xfb_offset=140) out float part7_0;
layout (location=7, component=1, xfb_buffer=0, xfb_offset=136) out float part7_1;
layout (location=7, component=2, xfb_buffer=0, xfb_offset=132) out float part7_2;
layout (location=7, component=3, xfb_buffer=0, xfb_offset=128) out float part7_3;
layout (location=8, component=0, xfb_buffer=0, xfb_offset=156) out float part8_0;
layout (location=8, component=1, xfb_buffer=0, xfb_offset=152) out float part8_1;
layout (location=8, component=2, xfb_buffer=0, xfb_offset=148) out float part8_2;
layout (location=8, component=3, xfb_buffer=0, xfb_offset=144) out float part8_3;
layout (location=9, component=0, xfb_buffer=0, xfb_offset=172) out float part9_0;
layout (location=9, component=1, xfb_buffer=0, xfb_offset=168) out float part9_1;
layout (location=9, component=2, xfb_buffer=0, xfb_offset=164) out float part9_2;
layout (location=9, component=3, xfb_buffer=0, xfb_offset=160) out float part9_3;
layout (location=10, component=0, xfb_buffer=0, xfb_offset=188) out float part10_0;
layout (location=10, component=1, xfb_buffer=0, xfb_offset=184) out float part10_1;
layout (location=10, component=2, xfb_buffer=0, xfb_offset=180) out float part10_2;
layout (location=10, component=3, xfb_buffer=0, xfb_offset=176) out float part10_3;
layout (location=11, component=0, xfb_buffer=0, xfb_offset=204) out float part11_0;
layout (location=11, component=1, xfb_buffer=0, xfb_offset=200) out float part11_1;
layout (location=11, component=2, xfb_buffer=0, xfb_offset=196) out float part11_2;
layout (location=11, component=3, xfb_buffer=0, xfb_offset=192) out float part11_3;
layout (location=12, component=0, xfb_buffer=0, xfb_offset=220) out float part12_0;
layout (location=12, component=1, xfb_buffer=0, xfb_offset=216) out float part12_1;
layout (location=12, component=2, xfb_buffer=0, xfb_offset=212) out float part12_2;
layout (location=12, component=3, xfb_buffer=0, xfb_offset=208) out float part12_3;
layout (location=13, component=0, xfb_buffer=0, xfb_offset=236) out float part13_0;
layout (location=13, component=1, xfb_buffer=0, xfb_offset=232) out float part13_1;
layout (location=13, component=2, xfb_buffer=0, xfb_offset=228) out float part13_2;
layout (location=13, component=3, xfb_buffer=0, xfb_offset=224) out float part13_3;
layout (location=14, component=0, xfb_buffer=0, xfb_offset=252) out float part14_0;
layout (location=14, component=1, xfb_buffer=0, xfb_offset=248) out float part14_1;
layout (location=14, component=2, xfb_buffer=0, xfb_offset=244) out float part14_2;
layout (location=14, component=3, xfb_buffer=0, xfb_offset=240) out float part14_3;

void main (void)
{
    const float baseValue = (gl_VertexIndex + 1) * 10000.0;
    gl_Position = inPos;
    part0_0 = baseValue + 1 * 10.0 + 0.0;
    part0_1 = baseValue + 1 * 10.0 + 1.0;
    part0_2 = baseValue + 1 * 10.0 + 2.0;
    part0_3 = baseValue + 1 * 10.0 + 3.0;
    part1_0 = baseValue + 2 * 10.0 + 0.0;
    part1_1 = baseValue + 2 * 10.0 + 1.0;
    part1_2 = baseValue + 2 * 10.0 + 2.0;
    part1_3 = baseValue + 2 * 10.0 + 3.0;
    part2_0 = baseValue + 3 * 10.0 + 0.0;
    part2_1 = baseValue + 3 * 10.0 + 1.0;
    part2_2 = baseValue + 3 * 10.0 + 2.0;
    part2_3 = baseValue + 3 * 10.0 + 3.0;
    part3_0 = baseValue + 4 * 10.0 + 0.0;
    part3_1 = baseValue + 4 * 10.0 + 1.0;
    part3_2 = baseValue + 4 * 10.0 + 2.0;
    part3_3 = baseValue + 4 * 10.0 + 3.0;
    part4_0 = baseValue + 5 * 10.0 + 0.0;
    part4_1 = baseValue + 5 * 10.0 + 1.0;
    part4_2 = baseValue + 5 * 10.0 + 2.0;
    part4_3 = baseValue + 5 * 10.0 + 3.0;
    part5_0 = baseValue + 6 * 10.0 + 0.0;
    part5_1 = baseValue + 6 * 10.0 + 1.0;
    part5_2 = baseValue + 6 * 10.0 + 2.0;
    part5_3 = baseValue + 6 * 10.0 + 3.0;
    part6_0 = baseValue + 7 * 10.0 + 0.0;
    part6_1 = baseValue + 7 * 10.0 + 1.0;
    part6_2 = baseValue + 7 * 10.0 + 2.0;
    part6_3 = baseValue + 7 * 10.0 + 3.0;
    part7_0 = baseValue + 8 * 10.0 + 0.0;
    part7_1 = baseValue + 8 * 10.0 + 1.0;
    part7_2 = baseValue + 8 * 10.0 + 2.0;
    part7_3 = baseValue + 8 * 10.0 + 3.0;
    part8_0 = baseValue + 9 * 10.0 + 0.0;
    part8_1 = baseValue + 9 * 10.0 + 1.0;
    part8_2 = baseValue + 9 * 10.0 + 2.0;
    part8_3 = baseValue + 9 * 10.0 + 3.0;
    part9_0 = baseValue + 10 * 10.0 + 0.0;
    part9_1 = baseValue + 10 * 10.0 + 1.0;
    part9_2 = baseValue + 10 * 10.0 + 2.0;
    part9_3 = baseValue + 10 * 10.0 + 3.0;
    part10_0 = baseValue + 11 * 10.0 + 0.0;
    part10_1 = baseValue + 11 * 10.0 + 1.0;
    part10_2 = baseValue + 11 * 10.0 + 2.0;
    part10_3 = baseValue + 11 * 10.0 + 3.0;
    part11_0 = baseValue + 12 * 10.0 + 0.0;
    part11_1 = baseValue + 12 * 10.0 + 1.0;
    part11_2 = baseValue + 12 * 10.0 + 2.0;
    part11_3 = baseValue + 12 * 10.0 + 3.0;
    part12_0 = baseValue + 13 * 10.0 + 0.0;
    part12_1 = baseValue + 13 * 10.0 + 1.0;
    part12_2 = baseValue + 13 * 10.0 + 2.0;
    part12_3 = baseValue + 13 * 10.0 + 3.0;
    part13_0 = baseValue + 14 * 10.0 + 0.0;
    part13_1 = baseValue + 14 * 10.0 + 1.0;
    part13_2 = baseValue + 14 * 10.0 + 2.0;
    part13_3 = baseValue + 14 * 10.0 + 3.0;
    part14_0 = baseValue + 15 * 10.0 + 0.0;
    part14_1 = baseValue + 15 * 10.0 + 1.0;
    part14_2 = baseValue + 15 * 10.0 + 2.0;
    part14_3 = baseValue + 15 * 10.0 + 3.0;
}
#version 460

layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0, component=0, xfb_buffer=0, xfb_offset=28) out float part0_0;
layout (location=0, component=1, xfb_buffer=0, xfb_offset=24) out float part0_1;
layout (location=0, component=2, xfb_buffer=0, xfb_offset=20) out float part0_2;
layout (location=0, component=3, xfb_buffer=0, xfb_offset=16) out float part0_3;
layout (location=1, component=0, xfb_buffer=0, xfb_offset=44) out float part1_0;
layout (location=1, component=1, xfb_buffer=0, xfb_offset=40) out float part1_1;
layout (location=1, component=2, xfb_buffer=0, xfb_offset=36) out float part1_2;
layout (location=1, component=3, xfb_buffer=0, xfb_offset=32) out float part1_3;
layout (location=2, component=0, xfb_buffer=0, xfb_offset=60) out float part2_0;
layout (location=2, component=1, xfb_buffer=0, xfb_offset=56) out float part2_1;
layout (location=2, component=2, xfb_buffer=0, xfb_offset=52) out float part2_2;
layout (location=2, component=3, xfb_buffer=0, xfb_offset=48) out float part2_3;
layout (location=3, component=0, xfb_buffer=0, xfb_offset=76) out float part3_0;
layout (location=3, component=1, xfb_buffer=0, xfb_offset=72) out float part3_1;
layout (location=3, component=2, xfb_buffer=0, xfb_offset=68) out float part3_2;
layout (location=3, component=3, xfb_buffer=0, xfb_offset=64) out float part3_3;
layout (location=4, component=0, xfb_buffer=0, xfb_offset=92) out float part4_0;
layout (location=4, component=1, xfb_buffer=0, xfb_offset=88) out float part4_1;
layout (location=4, component=2, xfb_buffer=0, xfb_offset=84) out float part4_2;
layout (location=4, component=3, xfb_buffer=0, xfb_offset=80) out float part4_3;
layout (location=5, component=0, xfb_buffer=0, xfb_offset=108) out float part5_0;
layout (location=5, component=1, xfb_buffer=0, xfb_offset=104) out float part5_1;
layout (location=5, component=2, xfb_buffer=0, xfb_offset=100) out float part5_2;
layout (location=5, component=3, xfb_buffer=0, xfb_offset=96) out float part5_3;
layout (location=6, component=0, xfb_buffer=0, xfb_offset=124) out float part6_0;
layout (location=6, component=1, xfb_buffer=0, xfb_offset=120) out float part6_1;
layout (location=6, component=2, xfb_buffer=0, xfb_offset=116) out float part6_2;
layout (location=6, component=3, xfb_buffer=0, xfb_offset=112) out float part6_3;
layout (location=7, component=0, xfb_buffer=0, xfb_offset=140) out float part7_0;
layout (location=7, component=1, xfb_buffer=0, xfb_offset=136) out float part7_1;
layout (location=7, component=2, xfb_buffer=0, xfb_offset=132) out float part7_2;
layout (location=7, component=3, xfb_buffer=0, xfb_offset=128) out float part7_3;
layout (location=8, component=0, xfb_buffer=0, xfb_offset=156) out float part8_0;
layout (location=8, component=1, xfb_buffer=0, xfb_offset=152) out float part8_1;
layout (location=8, component=2, xfb_buffer=0, xfb_offset=148) out float part8_2;
layout (location=8, component=3, xfb_buffer=0, xfb_offset=144) out float part8_3;
layout (location=9, component=0, xfb_buffer=0, xfb_offset=172) out float part9_0;
layout (location=9, component=1, xfb_buffer=0, xfb_offset=168) out float part9_1;
layout (location=9, component=2, xfb_buffer=0, xfb_offset=164) out float part9_2;
layout (location=9, component=3, xfb_buffer=0, xfb_offset=160) out float part9_3;
layout (location=10, component=0, xfb_buffer=0, xfb_offset=188) out float part10_0;
layout (location=10, component=1, xfb_buffer=0, xfb_offset=184) out float part10_1;
layout (location=10, component=2, xfb_buffer=0, xfb_offset=180) out float part10_2;
layout (location=10, component=3, xfb_buffer=0, xfb_offset=176) out float part10_3;
layout (location=11, component=0, xfb_buffer=0, xfb_offset=204) out float part11_0;
layout (location=11, component=1, xfb_buffer=0, xfb_offset=200) out float part11_1;
layout (location=11, component=2, xfb_buffer=0, xfb_offset=196) out float part11_2;
layout (location=11, component=3, xfb_buffer=0, xfb_offset=192) out float part11_3;
layout (location=12, component=0, xfb_buffer=0, xfb_offset=220) out float part12_0;
layout (location=12, component=1, xfb_buffer=0, xfb_offset=216) out float part12_1;
layout (location=12, component=2, xfb_buffer=0, xfb_offset=212) out float part12_2;
layout (location=12, component=3, xfb_buffer=0, xfb_offset=208) out float part12_3;
layout (location=13, component=0, xfb_buffer=0, xfb_offset=236) out float part13_0;
layout (location=13, component=1, xfb_buffer=0, xfb_offset=232) out float part13_1;
layout (location=13, component=2, xfb_buffer=0, xfb_offset=228) out float part13_2;
layout (location=13, component=3, xfb_buffer=0, xfb_offset=224) out float part13_3;
layout (location=14, component=0, xfb_buffer=0, xfb_offset=252) out float part14_0;
layout (location=14, component=1, xfb_buffer=0, xfb_offset=248) out float part14_1;
layout (location=14, component=2, xfb_buffer=0, xfb_offset=244) out float part14_2;
layout (location=14, component=3, xfb_buffer=0, xfb_offset=240) out float part14_3;
layout (location=15, component=0, xfb_buffer=0, xfb_offset=268) out float part15_0;
layout (location=15, component=1, xfb_buffer=0, xfb_offset=264) out float part15_1;
layout (location=15, component=2, xfb_buffer=0, xfb_offset=260) out float part15_2;
layout (location=15, component=3, xfb_buffer=0, xfb_offset=256) out float part15_3;
layout (location=16, component=0, xfb_buffer=0, xfb_offset=284) out float part16_0;
layout (location=16, component=1, xfb_buffer=0, xfb_offset=280) out float part16_1;
layout (location=16, component=2, xfb_buffer=0, xfb_offset=276) out float part16_2;
layout (location=16, component=3, xfb_buffer=0, xfb_offset=272) out float part16_3;
layout (location=17, component=0, xfb_buffer=0, xfb_offset=300) out float part17_0;
layout (location=17, component=1, xfb_buffer=0, xfb_offset=296) out float part17_1;
layout (location=17, component=2, xfb_buffer=0, xfb_offset=292) out float part17_2;
layout (location=17, component=3, xfb_buffer=0, xfb_offset=288) out float part17_3;
layout (location=18, component=0, xfb_buffer=0, xfb_offset=316) out float part18_0;
layout (location=18, component=1, xfb_buffer=0, xfb_offset=312) out float part18_1;
layout (location=18, component=2, xfb_buffer=0, xfb_offset=308) out float part18_2;
layout (location=18, component=3, xfb_buffer=0, xfb_offset=304) out float part18_3;
layout (location=19, component=0, xfb_buffer=0, xfb_offset=332) out float part19_0;
layout (location=19, component=1, xfb_buffer=0, xfb_offset=328) out float part19_1;
layout (location=19, component=2, xfb_buffer=0, xfb_offset=324) out float part19_2;
layout (location=19, component=3, xfb_buffer=0, xfb_offset=320) out float part19_3;
layout (location=20, component=0, xfb_buffer=0, xfb_offset=348) out float part20_0;
layout (location=20, component=1, xfb_buffer=0, xfb_offset=344) out float part20_1;
layout (location=20, component=2, xfb_buffer=0, xfb_offset=340) out float part20_2;
layout (location=20, component=3, xfb_buffer=0, xfb_offset=336) out float part20_3;
layout (location=21, component=0, xfb_buffer=0, xfb_offset=364) out float part21_0;
layout (location=21, component=1, xfb_buffer=0, xfb_offset=360) out float part21_1;
layout (location=21, component=2, xfb_buffer=0, xfb_offset=356) out float part21_2;
layout (location=21, component=3, xfb_buffer=0, xfb_offset=352) out float part21_3;
layout (location=22, component=0, xfb_buffer=0, xfb_offset=380) out float part22_0;
layout (location=22, component=1, xfb_buffer=0, xfb_offset=376) out float part22_1;
layout (location=22, component=2, xfb_buffer=0, xfb_offset=372) out float part22_2;
layout (location=22, component=3, xfb_buffer=0, xfb_offset=368) out float part22_3;
layout (location=23, component=0, xfb_buffer=0, xfb_offset=396) out float part23_0;
layout (location=23, component=1, xfb_buffer=0, xfb_offset=392) out float part23_1;
layout (location=23, component=2, xfb_buffer=0, xfb_offset=388) out float part23_2;
layout (location=23, component=3, xfb_buffer=0, xfb_offset=384) out float part23_3;
layout (location=24, component=0, xfb_buffer=0, xfb_offset=412) out float part24_0;
layout (location=24, component=1, xfb_buffer=0, xfb_offset=408) out float part24_1;
layout (location=24, component=2, xfb_buffer=0, xfb_offset=404) out float part24_2;
layout (location=24, component=3, xfb_buffer=0, xfb_offset=400) out float part24_3;
layout (location=25, component=0, xfb_buffer=0, xfb_offset=428) out float part25_0;
layout (location=25, component=1, xfb_buffer=0, xfb_offset=424) out float part25_1;
layout (location=25, component=2, xfb_buffer=0, xfb_offset=420) out float part25_2;
layout (location=25, component=3, xfb_buffer=0, xfb_offset=416) out float part25_3;
layout (location=26, component=0, xfb_buffer=0, xfb_offset=444) out float part26_0;
layout (location=26, component=1, xfb_buffer=0, xfb_offset=440) out float part26_1;
layout (location=26, component=2, xfb_buffer=0, xfb_offset=436) out float part26_2;
layout (location=26, component=3, xfb_buffer=0, xfb_offset=432) out float part26_3;
layout (location=27, component=0, xfb_buffer=0, xfb_offset=460) out float part27_0;
layout (location=27, component=1, xfb_buffer=0, xfb_offset=456) out float part27_1;
layout (location=27, component=2, xfb_buffer=0, xfb_offset=452) out float part27_2;
layout (location=27, component=3, xfb_buffer=0, xfb_offset=448) out float part27_3;
layout (location=28, component=0, xfb_buffer=0, xfb_offset=476) out float part28_0;
layout (location=28, component=1, xfb_buffer=0, xfb_offset=472) out float part28_1;
layout (location=28, component=2, xfb_buffer=0, xfb_offset=468) out float part28_2;
layout (location=28, component=3, xfb_buffer=0, xfb_offset=464) out float part28_3;
layout (location=29, component=0, xfb_buffer=0, xfb_offset=492) out float part29_0;
layout (location=29, component=1, xfb_buffer=0, xfb_offset=488) out float part29_1;
layout (location=29, component=2, xfb_buffer=0, xfb_offset=484) out float part29_2;
layout (location=29, component=3, xfb_buffer=0, xfb_offset=480) out float part29_3;
layout (location=30, component=0, xfb_buffer=0, xfb_offset=508) out float part30_0;
layout (location=30, component=1, xfb_buffer=0, xfb_offset=504) out float part30_1;
layout (location=30, component=2, xfb_buffer=0, xfb_offset=500) out float part30_2;
layout (location=30, component=3, xfb_buffer=0, xfb_offset=496) out float part30_3;

void main (void)
{
    const float baseValue = (gl_VertexIndex + 1) * 10000.0;
    gl_Position = inPos;
    part0_0 = baseValue + 1 * 10.0 + 0.0;
    part0_1 = baseValue + 1 * 10.0 + 1.0;
    part0_2 = baseValue + 1 * 10.0 + 2.0;
    part0_3 = baseValue + 1 * 10.0 + 3.0;
    part1_0 = baseValue + 2 * 10.0 + 0.0;
    part1_1 = baseValue + 2 * 10.0 + 1.0;
    part1_2 = baseValue + 2 * 10.0 + 2.0;
    part1_3 = baseValue + 2 * 10.0 + 3.0;
    part2_0 = baseValue + 3 * 10.0 + 0.0;
    part2_1 = baseValue + 3 * 10.0 + 1.0;
    part2_2 = baseValue + 3 * 10.0 + 2.0;
    part2_3 = baseValue + 3 * 10.0 + 3.0;
    part3_0 = baseValue + 4 * 10.0 + 0.0;
    part3_1 = baseValue + 4 * 10.0 + 1.0;
    part3_2 = baseValue + 4 * 10.0 + 2.0;
    part3_3 = baseValue + 4 * 10.0 + 3.0;
    part4_0 = baseValue + 5 * 10.0 + 0.0;
    part4_1 = baseValue + 5 * 10.0 + 1.0;
    part4_2 = baseValue + 5 * 10.0 + 2.0;
    part4_3 = baseValue + 5 * 10.0 + 3.0;
    part5_0 = baseValue + 6 * 10.0 + 0.0;
    part5_1 = baseValue + 6 * 10.0 + 1.0;
    part5_2 = baseValue + 6 * 10.0 + 2.0;
    part5_3 = baseValue + 6 * 10.0 + 3.0;
    part6_0 = baseValue + 7 * 10.0 + 0.0;
    part6_1 = baseValue + 7 * 10.0 + 1.0;
    part6_2 = baseValue + 7 * 10.0 + 2.0;
    part6_3 = baseValue + 7 * 10.0 + 3.0;
    part7_0 = baseValue + 8 * 10.0 + 0.0;
    part7_1 = baseValue + 8 * 10.0 + 1.0;
    part7_2 = baseValue + 8 * 10.0 + 2.0;
    part7_3 = baseValue + 8 * 10.0 + 3.0;
    part8_0 = baseValue + 9 * 10.0 + 0.0;
    part8_1 = baseValue + 9 * 10.0 + 1.0;
    part8_2 = baseValue + 9 * 10.0 + 2.0;
    part8_3 = baseValue + 9 * 10.0 + 3.0;
    part9_0 = baseValue + 10 * 10.0 + 0.0;
    part9_1 = baseValue + 10 * 10.0 + 1.0;
    part9_2 = baseValue + 10 * 10.0 + 2.0;
    part9_3 = baseValue + 10 * 10.0 + 3.0;
    part10_0 = baseValue + 11 * 10.0 + 0.0;
    part10_1 = baseValue + 11 * 10.0 + 1.0;
    part10_2 = baseValue + 11 * 10.0 + 2.0;
    part10_3 = baseValue + 11 * 10.0 + 3.0;
    part11_0 = baseValue + 12 * 10.0 + 0.0;
    part11_1 = baseValue + 12 * 10.0 + 1.0;
    part11_2 = baseValue + 12 * 10.0 + 2.0;
    part11_3 = baseValue + 12 * 10.0 + 3.0;
    part12_0 = baseValue + 13 * 10.0 + 0.0;
    part12_1 = baseValue + 13 * 10.0 + 1.0;
    part12_2 = baseValue + 13 * 10.0 + 2.0;
    part12_3 = baseValue + 13 * 10.0 + 3.0;
    part13_0 = baseValue + 14 * 10.0 + 0.0;
    part13_1 = baseValue + 14 * 10.0 + 1.0;
    part13_2 = baseValue + 14 * 10.0 + 2.0;
    part13_3 = baseValue + 14 * 10.0 + 3.0;
    part14_0 = baseValue + 15 * 10.0 + 0.0;
    part14_1 = baseValue + 15 * 10.0 + 1.0;
    part14_2 = baseValue + 15 * 10.0 + 2.0;
    part14_3 = baseValue + 15 * 10.0 + 3.0;
    part15_0 = baseValue + 16 * 10.0 + 0.0;
    part15_1 = baseValue + 16 * 10.0 + 1.0;
    part15_2 = baseValue + 16 * 10.0 + 2.0;
    part15_3 = baseValue + 16 * 10.0 + 3.0;
    part16_0 = baseValue + 17 * 10.0 + 0.0;
    part16_1 = baseValue + 17 * 10.0 + 1.0;
    part16_2 = baseValue + 17 * 10.0 + 2.0;
    part16_3 = baseValue + 17 * 10.0 + 3.0;
    part17_0 = baseValue + 18 * 10.0 + 0.0;
    part17_1 = baseValue + 18 * 10.0 + 1.0;
    part17_2 = baseValue + 18 * 10.0 + 2.0;
    part17_3 = baseValue + 18 * 10.0 + 3.0;
    part18_0 = baseValue + 19 * 10.0 + 0.0;
    part18_1 = baseValue + 19 * 10.0 + 1.0;
    part18_2 = baseValue + 19 * 10.0 + 2.0;
    part18_3 = baseValue + 19 * 10.0 + 3.0;
    part19_0 = baseValue + 20 * 10.0 + 0.0;
    part19_1 = baseValue + 20 * 10.0 + 1.0;
    part19_2 = baseValue + 20 * 10.0 + 2.0;
    part19_3 = baseValue + 20 * 10.0 + 3.0;
    part20_0 = baseValue + 21 * 10.0 + 0.0;
    part20_1 = baseValue + 21 * 10.0 + 1.0;
    part20_2 = baseValue + 21 * 10.0 + 2.0;
    part20_3 = baseValue + 21 * 10.0 + 3.0;
    part21_0 = baseValue + 22 * 10.0 + 0.0;
    part21_1 = baseValue + 22 * 10.0 + 1.0;
    part21_2 = baseValue + 22 * 10.0 + 2.0;
    part21_3 = baseValue + 22 * 10.0 + 3.0;
    part22_0 = baseValue + 23 * 10.0 + 0.0;
    part22_1 = baseValue + 23 * 10.0 + 1.0;
    part22_2 = baseValue + 23 * 10.0 + 2.0;
    part22_3 = baseValue + 23 * 10.0 + 3.0;
    part23_0 = baseValue + 24 * 10.0 + 0.0;
    part23_1 = baseValue + 24 * 10.0 + 1.0;
    part23_2 = baseValue + 24 * 10.0 + 2.0;
    part23_3 = baseValue + 24 * 10.0 + 3.0;
    part24_0 = baseValue + 25 * 10.0 + 0.0;
    part24_1 = baseValue + 25 * 10.0 + 1.0;
    part24_2 = baseValue + 25 * 10.0 + 2.0;
    part24_3 = baseValue + 25 * 10.0 + 3.0;
    part25_0 = baseValue + 26 * 10.0 + 0.0;
    part25_1 = baseValue + 26 * 10.0 + 1.0;
    part25_2 = baseValue + 26 * 10.0 + 2.0;
    part25_3 = baseValue + 26 * 10.0 + 3.0;
    part26_0 = baseValue + 27 * 10.0 + 0.0;
    part26_1 = baseValue + 27 * 10.0 + 1.0;
    part26_2 = baseValue + 27 * 10.0 + 2.0;
    part26_3 = baseValue + 27 * 10.0 + 3.0;
    part27_0 = baseValue + 28 * 10.0 + 0.0;
    part27_1 = baseValue + 28 * 10.0 + 1.0;
    part27_2 = baseValue + 28 * 10.0 + 2.0;
    part27_3 = baseValue + 28 * 10.0 + 3.0;
    part28_0 = baseValue + 29 * 10.0 + 0.0;
    part28_1 = baseValue + 29 * 10.0 + 1.0;
    part28_2 = baseValue + 29 * 10.0 + 2.0;
    part28_3 = baseValue + 29 * 10.0 + 3.0;
    part29_0 = baseValue + 30 * 10.0 + 0.0;
    part29_1 = baseValue + 30 * 10.0 + 1.0;
    part29_2 = baseValue + 30 * 10.0 + 2.0;
    part29_3 = baseValue + 30 * 10.0 + 3.0;
    part30_0 = baseValue + 31 * 10.0 + 0.0;
    part30_1 = baseValue + 31 * 10.0 + 1.0;
    part30_2 = baseValue + 31 * 10.0 + 2.0;
    part30_3 = baseValue + 31 * 10.0 + 3.0;
}
