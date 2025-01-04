#version 450
#extension GL_EXT_bfloat16: require
layout(binding=0) buffer InBufferX { bf16vec4 x[]; };
layout(binding=1) buffer InBufferY { bf16vec4 y[]; };
layout(binding=2) buffer OutBuffer { bf16vec4 z[]; };
layout(constant_id = 0)  const float c0 = 0.0;
layout(constant_id = 1)  const bfloat16_t c1 = bfloat16_t(0.0);
layout(constant_id = 2)  const float c2 = 0.0;
layout(constant_id = 3)  const bfloat16_t c3 = bfloat16_t(0.0);
layout(constant_id = 4)  const float c4 = 0.0;
layout(constant_id = 5)  const bfloat16_t c5 = bfloat16_t(0.0);
layout(constant_id = 6)  const bfloat16_t c6 = bfloat16_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const bfloat16_t c8 = bfloat16_t(0.0);
layout(constant_id = 9)  const bfloat16_t c9 = bfloat16_t(0.0);
layout(constant_id = 10) const bfloat16_t c10 = bfloat16_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
layout(constant_id = 12) const bfloat16_t c12 = bfloat16_t(0.0);
layout(constant_id = 13) const bfloat16_t c13 = bfloat16_t(0.0);
void main() {
    z[0]  = bf16vec4(bfloat16_t(c0));
    z[1]  = bf16vec4(bfloat16_t(c1));
    z[2]  = bf16vec4(bfloat16_t(c2));
    z[3]  = bf16vec4(bfloat16_t(c3));
    z[4]  = bf16vec4(bfloat16_t(c4));
    z[5]  = bf16vec4(bfloat16_t(c5));
    z[6]  = bf16vec4(bfloat16_t(c6));
    z[7]  = bf16vec4(bfloat16_t(c7));
    z[8]  = bf16vec4(bfloat16_t(c8));
    z[9]  = bf16vec4(bfloat16_t(c9));
    z[10] = bf16vec4(bfloat16_t(c10));
    z[11] = bf16vec4(bfloat16_t(c11));
    z[12] = bf16vec4(bfloat16_t(c12));
    z[13] = bf16vec4(bfloat16_t(c13));

    gl_Position = vec4(float(z[gl_VertexIndex * 2].x), float(z[gl_VertexIndex * 2 + 1].y), 0, 1);
}
