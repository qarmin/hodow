    #version 450
    #extension GL_EXT_bfloat16: require
    layout(binding=0) buffer InBufferX { bf16vec4 x[]; };
    layout(binding=1) buffer InBufferY { bf16vec4 y[]; };
    layout(binding=2) buffer OutBuffer { bfloat16_t z[]; };
    layout(push_constant) uniform PC { uint mode; };
    layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
    void main() {
        uint id = gl_WorkGroupID.z * gl_NumWorkGroups.x * gl_NumWorkGroups.y
            + gl_WorkGroupID.y * gl_NumWorkGroups.x + gl_WorkGroupID.x;
        switch (mode) {
            case 3:
                 z[id] = dot(bf16vec4(x[id]), bf16vec4(y[id]));
                 break;
            case 2:
                 z[id] = dot(bf16vec3(x[id]), bf16vec3(y[id]));
                 break;
            case 1:
                 z[id] = dot(bf16vec2(x[id]), bf16vec2(y[id]));
                 break;
            default:
                 z[id] = bfloat16_t(1.0);
        }
    }

    #version 450
    #extension GL_EXT_bfloat16 : require
    #extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
    layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
    layout(push_constant) uniform PC { uint variant; };
    struct A
    {
        bfloat16_t f1;
        bf16vec2   f2;
        bf16vec3   f3;
        bf16vec4   f4;
    };
    layout(binding = 0) buffer Input { A a0; A a1; } inp;
    layout(binding = 1) buffer Output { A a0; A a1; } outp;

    void main()
    {
        outp.a0.f1 = inp.a1.f1;
        outp.a0.f2 = inp.a1.f2;
        outp.a0.f3 = inp.a1.f3;
        outp.a0.f4 = inp.a1.f4;

        outp.a1 = inp.a0;
    }

    #version 450
    #extension GL_EXT_bfloat16 : require
    #extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
    layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
    layout(push_constant) uniform PC { uint v; };
    struct A
    {
        bfloat16_t f1;
        bf16vec2   f2;
        bf16vec3   f3;
        bf16vec4   f4;
    };
    layout(binding = 0) buffer Input { A inp; };
    layout(binding = 1) buffer Output { A outp[]; };

    void next(bfloat16_t u, out bfloat16_t v, uint k) { v = u; }
    void next(bf16vec2   u, out bf16vec2   v, uint k) { v = (k % 2) == 1 ? u.yx : u.xy; }
    void next(bf16vec3   u, out bf16vec3   v, uint k) {
        switch (k) {
        case  0:   v = u.xyz;   break;
        case  1:   v = u.xzy;   break;
        case  2:   v = u.yxz;   break;
        case  3:   v = u.yzx;   break;
        case  4:   v = u.zxy;   break;
        case  5:   v = u.zyx;   break;
        }
    }
    void next(bf16vec4   u, out bf16vec4   v, uint k) {
        switch (k) {
        case  0:   v = u.xyzw;   break;
        case  1:   v = u.xywz;   break;
        case  2:   v = u.xzyw;   break;
        case  3:   v = u.xzwy;   break;
        case  4:   v = u.xwyz;   break;
        case  5:   v = u.xwzy;   break;
        case  6:   v = u.yxzw;   break;
        case  7:   v = u.yxwz;   break;
        case  8:   v = u.yzxw;   break;
        case  9:   v = u.yzwx;   break;
        case 10:   v = u.ywxz;   break;
        case 11:   v = u.ywzx;   break;
        case 12:   v = u.zxyw;   break;
        case 13:   v = u.zxwy;   break;
        case 14:   v = u.zyxw;   break;
        case 15:   v = u.zywx;   break;
        case 16:   v = u.zwxy;   break;
        case 17:   v = u.zwyx;   break;
        case 18:   v = u.wxyz;   break;
        case 19:   v = u.wxzy;   break;
        case 20:   v = u.wyxz;   break;
        case 21:   v = u.wyzx;   break;
        case 22:   v = u.wzxy;   break;
        case 23:   v = u.wzyx;   break;
        }
    }
    void main() {
        for (uint u = 0; u < v; ++u) {
            next(inp.f1, outp[u].f1, u);
            next(inp.f2, outp[u].f2, u);
            next(inp.f3, outp[u].f3, u % 6);
            next(inp.f4, outp[u].f4, u % 24);
        }
    }

    #version 450
    #extension GL_EXT_bfloat16 : require
    #extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
    layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
    layout(push_constant) uniform PC { uint variant; };
    struct A
    {
        bfloat16_t f1;
        bf16vec2   f2;
        bf16vec3   f3;
        bf16vec4   f4;
    };
    struct B
    {
        A        a;
        bf16vec2 b[3];
        A        c[3];
        bf16vec3 d[2];
    };
    layout(binding = 0) buffer Input { B inp[3]; };
    layout(binding = 1) buffer Output { B outp[3]; };

    void main()
    {
        outp[0].a.f1 = inp[1].a.f1;
        outp[1].a.f1 = inp[2].a.f1;
        outp[2].a.f1 = inp[0].a.f1;

        outp[0].c[0].f1 = inp[1].c[1].f1;
        outp[1].c[1].f1 = inp[2].c[2].f1;
        outp[2].c[2].f1 = inp[0].c[0].f1;

        for (uint c = 0; c < 3; ++c)
        {
            const uint c_prim = (c + 1) % 3;
            for (uint b = 0; b < 2; ++b)
            {
                const uint b_prim = (b + 1) % 2;

                outp[c].b[c_prim][b] = inp[c_prim].b[c][b_prim];
                outp[c_prim].d[b_prim][c] = inp[c].d[b][c_prim];
            }
        }
    }

    #version 450
    #extension GL_EXT_bfloat16 : require
    #extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
    #define RET_IN 0
    #define RET_REF 1
    layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
    layout(push_constant) uniform PC { uint variant; };
    layout(binding = 0) buffer Input { bfloat16_t inp[]; };
    layout(binding = 1) buffer Output { bfloat16_t outp[]; };

    bfloat16_t ret_in_1(bfloat16_t x) { return x; }
    bf16vec2   ret_in_2(bf16vec2   xy) { return bf16vec2(xy.y, xy.x); }
    bf16vec3   ret_in_3(bf16vec3   xyz) { return bf16vec3(xyz.z, xyz.y, xyz.x); }
    bf16vec4   ret_in_4(bf16vec4   xyzw) { return bf16vec4(xyzw.w, xyzw.z, xyzw.y, xyzw.x); }

    void ret_ref_1(bfloat16_t x,    out bfloat16_t ref) { ref = ret_in_1(x); }
    void ret_ref_2(bf16vec2   xy,   out bf16vec2   ref) { ref = ret_in_2(xy); }
    void ret_ref_3(bf16vec3   xyz,  out bf16vec3   ref) { ref = ret_in_3(xyz); }
    void ret_ref_4(bf16vec4   xyzw, out bf16vec4   ref) { ref = ret_in_4(xyzw); }

    void main() {

        float16_t aaa = float16_t(1.0);
        float16_t bbb = float16_t(1.0);
        float16_t ccc = aaa * bbb;

        bfloat16_t x_in,   x_res;
        bf16vec2   xy_in, xy_res;
        bf16vec3   xyz_in, xyz_res;
        bf16vec4   xyzw_in, xyzw_res;

        x_in = inp[0];
        xy_in.x = inp[1];
        xy_in.y = inp[2];
        xyz_in.x = inp[3];
        xyz_in.y = inp[4];
        xyz_in.z = inp[5];
        xyzw_in.x = inp[6];
        xyzw_in.y = inp[7];
        xyzw_in.z = inp[8];
        xyzw_in.w = inp[9];

        if (variant == RET_IN)
        {
            x_res = ret_in_1(x_in);
            outp[(variant * 8 * 4) + (0 * 4) + 0] = x_res;

            xy_res = ret_in_2(xy_in);
            outp[(variant * 8 * 4) + (1 * 4) + 0] = xy_res.x;
            outp[(variant * 8 * 4) + (1 * 4) + 1] = xy_res.y;

            xyz_res = ret_in_3(xyz_in);
            outp[(variant * 8 * 4) + (2 * 4) + 0] = xyz_res.x;
            outp[(variant * 8 * 4) + (2 * 4) + 1] = xyz_res.y;
            outp[(variant * 8 * 4) + (2 * 4) + 2] = xyz_res.z;

            xyzw_res = ret_in_4(xyzw_in);
            outp[(variant * 8 * 4) + (3 * 4) + 0] = xyzw_res.x;
            outp[(variant * 8 * 4) + (3 * 4) + 1] = xyzw_res.y;
            outp[(variant * 8 * 4) + (3 * 4) + 2] = xyzw_res.z;
            outp[(variant * 8 * 4) + (3 * 4) + 3] = xyzw_res.w;
        }
        else if (variant == RET_REF)
        {
            ret_ref_1(x_in, x_res);
            outp[(variant * 8 * 4) + (0 * 4) + 0] = x_res;

            ret_ref_2(xy_in, xy_res);
            outp[(variant * 8 * 4) + (1 * 4) + 0] = xy_res.x;
            outp[(variant * 8 * 4) + (1 * 4) + 1] = xy_res.y;

            ret_ref_3(xyz_in, xyz_res);
            outp[(variant * 8 * 4) + (2 * 4) + 0] = xyz_res.x;
            outp[(variant * 8 * 4) + (2 * 4) + 1] = xyz_res.y;
            outp[(variant * 8 * 4) + (2 * 4) + 2] = xyz_res.z;

            ret_ref_4(xyzw_in, xyzw_res);
            outp[(variant * 8 * 4) + (3 * 4) + 0] = xyzw_res.x;
            outp[(variant * 8 * 4) + (3 * 4) + 1] = xyzw_res.y;
            outp[(variant * 8 * 4) + (3 * 4) + 2] = xyzw_res.z;
            outp[(variant * 8 * 4) + (3 * 4) + 3] = xyzw_res.w;
        }
    }
