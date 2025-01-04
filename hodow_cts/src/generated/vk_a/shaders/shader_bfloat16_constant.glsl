#version 450
#extension GL_EXT_bfloat16: require
layout(binding=0) buffer InBufferX { bf16vec4 x[]; };
layout(binding=1) buffer InBufferY { bf16vec4 y[]; };
layout(binding=2) buffer OutBuffer { bf16vec4 z[]; };
layout(local_size_x_id = 0, local_size_y_id = 2, local_size_z_id = 4) in;
// local_size_x_id
layout(constant_id = 1)  const bfloat16_t c1 = bfloat16_t(0.0);
// local_size_y_id
layout(constant_id = 3)  const bfloat16_t c3 = bfloat16_t(0.0);
// local_size_z_id
layout(constant_id = 5)  const bfloat16_t c5 = bfloat16_t(0.0);
layout(constant_id = 6)  const bfloat16_t c6 = bfloat16_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const bfloat16_t c8 = bfloat16_t(0.0);
layout(constant_id = 9)  const bfloat16_t c9 = bfloat16_t(0.0);
layout(constant_id = 10) const bfloat16_t c10 = bfloat16_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
const bfloat16_t c12 = bfloat16_t(c11);
const float c13 = float(c12);
void main() {
    z[0].x = bfloat16_t(float(gl_WorkGroupSize.x));
    z[0].y = bfloat16_t(c1);
    z[0].z = bfloat16_t(float(gl_WorkGroupSize.y));
    z[0].w = bfloat16_t(c3);
    z[1].x = bfloat16_t(float(gl_WorkGroupSize.z));
    z[1].y = bfloat16_t(c5);
    z[1].z = bfloat16_t(c6);
    z[1].w = bfloat16_t(c7);
    z[2].x = bfloat16_t(c8);
    z[2].y = bfloat16_t(c9);
    z[2].z = bfloat16_t(c10);
    z[2].w = bfloat16_t(c13);
}
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
#version 450
layout(location = 0) out vec4 color;
void main() {
    color = vec4(1);
}
#version 450
layout(location = 0) in vec4 pos;
void main() {
    gl_Position = pos;
}
#version 450
#extension GL_EXT_bfloat16: require
layout(binding=0) buffer InBufferX { bf16vec4 x[]; };
layout(binding=1) buffer InBufferY { bf16vec4 y[]; };
layout(binding=2) buffer OutBuffer { bf16vec4 z[]; };
layout(location = 0) out vec4 color;
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
void copy() {
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
}
void main() {
    copy();
    const float c = float(gl_PrimitiveID + 1);
    color = vec4(c, c, c, 1.0);
}
#version 450
#extension GL_EXT_float_e5m2: require
layout(binding=0) buffer InBufferX { fe5m2vec4 x[]; };
layout(binding=1) buffer InBufferY { fe5m2vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe5m2vec4 z[]; };
layout(local_size_x_id = 0, local_size_y_id = 2, local_size_z_id = 4) in;
// local_size_x_id
layout(constant_id = 1)  const floate5m2_t c1 = floate5m2_t(0.0);
// local_size_y_id
layout(constant_id = 3)  const floate5m2_t c3 = floate5m2_t(0.0);
// local_size_z_id
layout(constant_id = 5)  const floate5m2_t c5 = floate5m2_t(0.0);
layout(constant_id = 6)  const floate5m2_t c6 = floate5m2_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate5m2_t c8 = floate5m2_t(0.0);
layout(constant_id = 9)  const floate5m2_t c9 = floate5m2_t(0.0);
layout(constant_id = 10) const floate5m2_t c10 = floate5m2_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
const floate5m2_t c12 = floate5m2_t(c11);
const float c13 = float(c12);
void main() {
    z[0].x = floate5m2_t(float(gl_WorkGroupSize.x));
    z[0].y = floate5m2_t(c1);
    z[0].z = floate5m2_t(float(gl_WorkGroupSize.y));
    z[0].w = floate5m2_t(c3);
    z[1].x = floate5m2_t(float(gl_WorkGroupSize.z));
    z[1].y = floate5m2_t(c5);
    z[1].z = floate5m2_t(c6);
    z[1].w = floate5m2_t(c7);
    z[2].x = floate5m2_t(c8);
    z[2].y = floate5m2_t(c9);
    z[2].z = floate5m2_t(c10);
    z[2].w = floate5m2_t(c13);
}
#version 450
#extension GL_EXT_float_e5m2: require
layout(binding=0) buffer InBufferX { fe5m2vec4 x[]; };
layout(binding=1) buffer InBufferY { fe5m2vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe5m2vec4 z[]; };
layout(constant_id = 0)  const float c0 = 0.0;
layout(constant_id = 1)  const floate5m2_t c1 = floate5m2_t(0.0);
layout(constant_id = 2)  const float c2 = 0.0;
layout(constant_id = 3)  const floate5m2_t c3 = floate5m2_t(0.0);
layout(constant_id = 4)  const float c4 = 0.0;
layout(constant_id = 5)  const floate5m2_t c5 = floate5m2_t(0.0);
layout(constant_id = 6)  const floate5m2_t c6 = floate5m2_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate5m2_t c8 = floate5m2_t(0.0);
layout(constant_id = 9)  const floate5m2_t c9 = floate5m2_t(0.0);
layout(constant_id = 10) const floate5m2_t c10 = floate5m2_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
layout(constant_id = 12) const floate5m2_t c12 = floate5m2_t(0.0);
layout(constant_id = 13) const floate5m2_t c13 = floate5m2_t(0.0);
void main() {
    z[0]  = fe5m2vec4(floate5m2_t(c0));
    z[1]  = fe5m2vec4(floate5m2_t(c1));
    z[2]  = fe5m2vec4(floate5m2_t(c2));
    z[3]  = fe5m2vec4(floate5m2_t(c3));
    z[4]  = fe5m2vec4(floate5m2_t(c4));
    z[5]  = fe5m2vec4(floate5m2_t(c5));
    z[6]  = fe5m2vec4(floate5m2_t(c6));
    z[7]  = fe5m2vec4(floate5m2_t(c7));
    z[8]  = fe5m2vec4(floate5m2_t(c8));
    z[9]  = fe5m2vec4(floate5m2_t(c9));
    z[10] = fe5m2vec4(floate5m2_t(c10));
    z[11] = fe5m2vec4(floate5m2_t(c11));
    z[12] = fe5m2vec4(floate5m2_t(c12));
    z[13] = fe5m2vec4(floate5m2_t(c13));

    gl_Position = vec4(float(z[gl_VertexIndex * 2].x), float(z[gl_VertexIndex * 2 + 1].y), 0, 1);
}
#version 450
#extension GL_EXT_float_e5m2: require
layout(binding=0) buffer InBufferX { fe5m2vec4 x[]; };
layout(binding=1) buffer InBufferY { fe5m2vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe5m2vec4 z[]; };
layout(location = 0) out vec4 color;
layout(constant_id = 0)  const float c0 = 0.0;
layout(constant_id = 1)  const floate5m2_t c1 = floate5m2_t(0.0);
layout(constant_id = 2)  const float c2 = 0.0;
layout(constant_id = 3)  const floate5m2_t c3 = floate5m2_t(0.0);
layout(constant_id = 4)  const float c4 = 0.0;
layout(constant_id = 5)  const floate5m2_t c5 = floate5m2_t(0.0);
layout(constant_id = 6)  const floate5m2_t c6 = floate5m2_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate5m2_t c8 = floate5m2_t(0.0);
layout(constant_id = 9)  const floate5m2_t c9 = floate5m2_t(0.0);
layout(constant_id = 10) const floate5m2_t c10 = floate5m2_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
layout(constant_id = 12) const floate5m2_t c12 = floate5m2_t(0.0);
layout(constant_id = 13) const floate5m2_t c13 = floate5m2_t(0.0);
void copy() {
    z[0]  = fe5m2vec4(floate5m2_t(c0));
    z[1]  = fe5m2vec4(floate5m2_t(c1));
    z[2]  = fe5m2vec4(floate5m2_t(c2));
    z[3]  = fe5m2vec4(floate5m2_t(c3));
    z[4]  = fe5m2vec4(floate5m2_t(c4));
    z[5]  = fe5m2vec4(floate5m2_t(c5));
    z[6]  = fe5m2vec4(floate5m2_t(c6));
    z[7]  = fe5m2vec4(floate5m2_t(c7));
    z[8]  = fe5m2vec4(floate5m2_t(c8));
    z[9]  = fe5m2vec4(floate5m2_t(c9));
    z[10] = fe5m2vec4(floate5m2_t(c10));
    z[11] = fe5m2vec4(floate5m2_t(c11));
    z[12] = fe5m2vec4(floate5m2_t(c12));
    z[13] = fe5m2vec4(floate5m2_t(c13));
}
void main() {
    copy();
    const float c = float(gl_PrimitiveID + 1);
    color = vec4(c, c, c, 1.0);
}
#version 450
#extension GL_EXT_float_e4m3: require
layout(binding=0) buffer InBufferX { fe4m3vec4 x[]; };
layout(binding=1) buffer InBufferY { fe4m3vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe4m3vec4 z[]; };
layout(local_size_x_id = 0, local_size_y_id = 2, local_size_z_id = 4) in;
// local_size_x_id
layout(constant_id = 1)  const floate4m3_t c1 = floate4m3_t(0.0);
// local_size_y_id
layout(constant_id = 3)  const floate4m3_t c3 = floate4m3_t(0.0);
// local_size_z_id
layout(constant_id = 5)  const floate4m3_t c5 = floate4m3_t(0.0);
layout(constant_id = 6)  const floate4m3_t c6 = floate4m3_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate4m3_t c8 = floate4m3_t(0.0);
layout(constant_id = 9)  const floate4m3_t c9 = floate4m3_t(0.0);
layout(constant_id = 10) const floate4m3_t c10 = floate4m3_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
const floate4m3_t c12 = floate4m3_t(c11);
const float c13 = float(c12);
void main() {
    z[0].x = floate4m3_t(float(gl_WorkGroupSize.x));
    z[0].y = floate4m3_t(c1);
    z[0].z = floate4m3_t(float(gl_WorkGroupSize.y));
    z[0].w = floate4m3_t(c3);
    z[1].x = floate4m3_t(float(gl_WorkGroupSize.z));
    z[1].y = floate4m3_t(c5);
    z[1].z = floate4m3_t(c6);
    z[1].w = floate4m3_t(c7);
    z[2].x = floate4m3_t(c8);
    z[2].y = floate4m3_t(c9);
    z[2].z = floate4m3_t(c10);
    z[2].w = floate4m3_t(c13);
}
#version 450
#extension GL_EXT_float_e4m3: require
layout(binding=0) buffer InBufferX { fe4m3vec4 x[]; };
layout(binding=1) buffer InBufferY { fe4m3vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe4m3vec4 z[]; };
layout(constant_id = 0)  const float c0 = 0.0;
layout(constant_id = 1)  const floate4m3_t c1 = floate4m3_t(0.0);
layout(constant_id = 2)  const float c2 = 0.0;
layout(constant_id = 3)  const floate4m3_t c3 = floate4m3_t(0.0);
layout(constant_id = 4)  const float c4 = 0.0;
layout(constant_id = 5)  const floate4m3_t c5 = floate4m3_t(0.0);
layout(constant_id = 6)  const floate4m3_t c6 = floate4m3_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate4m3_t c8 = floate4m3_t(0.0);
layout(constant_id = 9)  const floate4m3_t c9 = floate4m3_t(0.0);
layout(constant_id = 10) const floate4m3_t c10 = floate4m3_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
layout(constant_id = 12) const floate4m3_t c12 = floate4m3_t(0.0);
layout(constant_id = 13) const floate4m3_t c13 = floate4m3_t(0.0);
void main() {
    z[0]  = fe4m3vec4(floate4m3_t(c0));
    z[1]  = fe4m3vec4(floate4m3_t(c1));
    z[2]  = fe4m3vec4(floate4m3_t(c2));
    z[3]  = fe4m3vec4(floate4m3_t(c3));
    z[4]  = fe4m3vec4(floate4m3_t(c4));
    z[5]  = fe4m3vec4(floate4m3_t(c5));
    z[6]  = fe4m3vec4(floate4m3_t(c6));
    z[7]  = fe4m3vec4(floate4m3_t(c7));
    z[8]  = fe4m3vec4(floate4m3_t(c8));
    z[9]  = fe4m3vec4(floate4m3_t(c9));
    z[10] = fe4m3vec4(floate4m3_t(c10));
    z[11] = fe4m3vec4(floate4m3_t(c11));
    z[12] = fe4m3vec4(floate4m3_t(c12));
    z[13] = fe4m3vec4(floate4m3_t(c13));

    gl_Position = vec4(float(z[gl_VertexIndex * 2].x), float(z[gl_VertexIndex * 2 + 1].y), 0, 1);
}
#version 450
#extension GL_EXT_float_e4m3: require
layout(binding=0) buffer InBufferX { fe4m3vec4 x[]; };
layout(binding=1) buffer InBufferY { fe4m3vec4 y[]; };
layout(binding=2) buffer OutBuffer { fe4m3vec4 z[]; };
layout(location = 0) out vec4 color;
layout(constant_id = 0)  const float c0 = 0.0;
layout(constant_id = 1)  const floate4m3_t c1 = floate4m3_t(0.0);
layout(constant_id = 2)  const float c2 = 0.0;
layout(constant_id = 3)  const floate4m3_t c3 = floate4m3_t(0.0);
layout(constant_id = 4)  const float c4 = 0.0;
layout(constant_id = 5)  const floate4m3_t c5 = floate4m3_t(0.0);
layout(constant_id = 6)  const floate4m3_t c6 = floate4m3_t(0.0);
layout(constant_id = 7)  const float c7 = 0.0;
layout(constant_id = 8)  const floate4m3_t c8 = floate4m3_t(0.0);
layout(constant_id = 9)  const floate4m3_t c9 = floate4m3_t(0.0);
layout(constant_id = 10) const floate4m3_t c10 = floate4m3_t(0.0);
layout(constant_id = 11) const float c11 = 0.0;
layout(constant_id = 12) const floate4m3_t c12 = floate4m3_t(0.0);
layout(constant_id = 13) const floate4m3_t c13 = floate4m3_t(0.0);
void copy() {
    z[0]  = fe4m3vec4(floate4m3_t(c0));
    z[1]  = fe4m3vec4(floate4m3_t(c1));
    z[2]  = fe4m3vec4(floate4m3_t(c2));
    z[3]  = fe4m3vec4(floate4m3_t(c3));
    z[4]  = fe4m3vec4(floate4m3_t(c4));
    z[5]  = fe4m3vec4(floate4m3_t(c5));
    z[6]  = fe4m3vec4(floate4m3_t(c6));
    z[7]  = fe4m3vec4(floate4m3_t(c7));
    z[8]  = fe4m3vec4(floate4m3_t(c8));
    z[9]  = fe4m3vec4(floate4m3_t(c9));
    z[10] = fe4m3vec4(floate4m3_t(c10));
    z[11] = fe4m3vec4(floate4m3_t(c11));
    z[12] = fe4m3vec4(floate4m3_t(c12));
    z[13] = fe4m3vec4(floate4m3_t(c13));
}
void main() {
    copy();
    const float c = float(gl_PrimitiveID + 1);
    color = vec4(c, c, c, 1.0);
}
