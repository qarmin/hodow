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
