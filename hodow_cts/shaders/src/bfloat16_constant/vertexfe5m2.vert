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
