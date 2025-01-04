// Kernels of `hodow bench`. R (blur radius), TW/TH (the local-memory tile) and VN
// (pixels per work-item of the vector variants) come in as -D options, so each row builds
// the program it times.

#ifndef R
#define R 0
#endif
#ifndef TW
#define TW 32
#endif
#ifndef TH
#define TH 8
#endif
#ifndef VN
#define VN 4
#endif
#if VN > 8
#define DN 8
#else
#define DN VN
#endif
#define TAPS (2 * R + 1)

#define CAT(a, b) a##b
#define XCAT(a, b) CAT(a, b)
#define UINTN XCAT(uint, VN)
#define VLOADN XCAT(vload, VN)
#define VSTOREN XCAT(vstore, VN)
#define CONVERT_UINTN XCAT(convert_uint, VN)
#define CONVERT_USHORTN XCAT(convert_ushort, VN)
#define CONVERT_UCHARN XCAT(convert_uchar, VN)
#if DN == 8
#define TWO_DN 16
#elif DN == 4
#define TWO_DN 8
#else
#define TWO_DN 4
#endif
#define UINTDN XCAT(uint, DN)
#define UINT2DN XCAT(uint, TWO_DN)
#define VLOAD2DN XCAT(vload, TWO_DN)
#define VSTOREDN XCAT(vstore, DN)
#define CONVERT_UINT2DN XCAT(convert_uint, TWO_DN)
#define CONVERT_UCHARDN XCAT(convert_uchar, DN)

__constant sampler_t clamp_nearest = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

inline uchar luma(uint r, uint g1, uint g2, uint b) {
    return (uchar)((77u * r + 75u * (g1 + g2) + 29u * b) >> 10);
}

__kernel void debayer(__global const ushort* src, __global uchar* dst, int ow, int oh) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= ow || y >= oh) return;
    int sw = ow * 2;
    __global const ushort* p = src + 2 * y * sw + 2 * x;
    dst[y * ow + x] = luma(p[0], p[1], p[sw], p[sw + 1]);
}

// VN pixels per work-item through vector loads; DN is VN capped at 8 for debayer, whose
// source row of a VN-pixel span is 2 * VN ushorts and vload16 is the widest there is.
__kernel void debayer_vec(__global const ushort* src, __global uchar* dst, int ow, int oh) {
    int x = get_global_id(0) * DN, y = get_global_id(1);
    if (x >= ow || y >= oh) return;
    int sw = ow * 2;
    __global const ushort* p = src + 2 * y * sw + 2 * x;
    if (x + DN <= ow) {
        UINT2DN a = CONVERT_UINT2DN(VLOAD2DN(0, p));
        UINT2DN b = CONVERT_UINT2DN(VLOAD2DN(0, p + sw));
        UINTDN v = 77u * a.even + 75u * (a.odd + b.even) + 29u * b.odd;
        VSTOREDN(CONVERT_UCHARDN(v >> 10), 0, dst + y * ow + x);
    } else {
        for (int i = 0; x + i < ow; i++)
            dst[y * ow + x + i] = luma(p[2 * i], p[2 * i + 1], p[sw + 2 * i], p[sw + 2 * i + 1]);
    }
}

__kernel void debayer_image(__global const ushort* src, __write_only image2d_t dst, int ow, int oh) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= ow || y >= oh) return;
    int sw = ow * 2;
    __global const ushort* p = src + 2 * y * sw + 2 * x;
    write_imageui(dst, (int2)(x, y), (uint4)(luma(p[0], p[1], p[sw], p[sw + 1]), 0, 0, 0));
}

__kernel void blur_naive(__global const uchar* src, __global uchar* dst, __constant ushort* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    uint acc = 0;
    for (int j = -R; j <= R; j++) {
        __global const uchar* row = src + clamp(y + j, 0, h - 1) * w;
        uint sum = 0;
        for (int i = -R; i <= R; i++) sum += wt[i + R] * row[clamp(x + i, 0, w - 1)];
        acc += wt[j + R] * sum;
    }
    dst[y * w + x] = (uchar)((acc + 32768u) >> 16);
}

__kernel void blur_h(__global const uchar* src, __global ushort* dst, __constant ushort* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    __global const uchar* row = src + y * w;
    uint acc = 0;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * row[clamp(x + k, 0, w - 1)];
    dst[y * w + x] = (ushort)acc;
}

__kernel void blur_v(__global const ushort* src, __global uchar* dst, __constant ushort* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    uint acc = 0;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * src[clamp(y + k, 0, h - 1) * w + x];
    dst[y * w + x] = (uchar)((acc + 32768u) >> 16);
}

__kernel __attribute__((reqd_work_group_size(TW, TH, 1)))
void blur_h_local(__global const uchar* src, __global ushort* dst, __constant ushort* wt, int w, int h) {
    __local uchar tile[TH][TW + 2 * R];
    int lx = get_local_id(0), ly = get_local_id(1);
    int x0 = get_group_id(0) * TW;
    int y = min((int)get_global_id(1), h - 1);
    __global const uchar* row = src + y * w;
    for (int i = lx; i < TW + 2 * R; i += TW) tile[ly][i] = row[clamp(x0 + i - R, 0, w - 1)];
    barrier(CLK_LOCAL_MEM_FENCE);
    int x = x0 + lx;
    if (x >= w || (int)get_global_id(1) >= h) return;
    uint acc = 0;
    for (int k = 0; k < TAPS; k++) acc += wt[k] * tile[ly][lx + k];
    dst[y * w + x] = (ushort)acc;
}

__kernel __attribute__((reqd_work_group_size(TW, TH, 1)))
void blur_v_local(__global const ushort* src, __global uchar* dst, __constant ushort* wt, int w, int h) {
    __local ushort tile[TH + 2 * R][TW];
    int lx = get_local_id(0), ly = get_local_id(1);
    int x = min((int)get_global_id(0), w - 1);
    int y0 = get_group_id(1) * TH;
    for (int j = ly; j < TH + 2 * R; j += TH) tile[j][lx] = src[clamp(y0 + j - R, 0, h - 1) * w + x];
    barrier(CLK_LOCAL_MEM_FENCE);
    int y = y0 + ly;
    if ((int)get_global_id(0) >= w || y >= h) return;
    uint acc = 0;
    for (int k = 0; k < TAPS; k++) acc += wt[k] * tile[ly + k][lx];
    dst[y * w + x] = (uchar)((acc + 32768u) >> 16);
}

__kernel void blur_h_image(__read_only image2d_t src, __write_only image2d_t dst, __constant ushort* wt) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= get_image_width(src) || y >= get_image_height(src)) return;
    uint acc = 0;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * read_imageui(src, clamp_nearest, (int2)(x + k, y)).x;
    write_imageui(dst, (int2)(x, y), (uint4)(acc, 0, 0, 0));
}

__kernel void blur_v_image(__read_only image2d_t src, __global uchar* dst, __constant ushort* wt) {
    int x = get_global_id(0), y = get_global_id(1);
    int w = get_image_width(src);
    if (x >= w || y >= get_image_height(src)) return;
    uint acc = 0;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * read_imageui(src, clamp_nearest, (int2)(x, y + k)).x;
    dst[y * w + x] = (uchar)((acc + 32768u) >> 16);
}

__kernel void blur_h_vec(__global const uchar* src, __global ushort* dst, __constant ushort* wt, int w, int h) {
    int x = get_global_id(0) * VN, y = get_global_id(1);
    if (x >= w || y >= h) return;
    __global const uchar* row = src + y * w;
    if (x - R >= 0 && x + VN - 1 + R < w) {
        UINTN acc = 0;
        for (int k = -R; k <= R; k++) acc += (UINTN)(wt[k + R]) * CONVERT_UINTN(VLOADN(0, row + x + k));
        VSTOREN(CONVERT_USHORTN(acc), 0, dst + y * w + x);
    } else {
        for (int i = 0; i < VN && x + i < w; i++) {
            uint acc = 0;
            for (int k = -R; k <= R; k++) acc += wt[k + R] * row[clamp(x + i + k, 0, w - 1)];
            dst[y * w + x + i] = (ushort)acc;
        }
    }
}

__kernel void blur_v_vec(__global const ushort* src, __global uchar* dst, __constant ushort* wt, int w, int h) {
    int x = get_global_id(0) * VN, y = get_global_id(1);
    if (x >= w || y >= h) return;
    if (x + VN <= w) {
        UINTN acc = 0;
        for (int k = -R; k <= R; k++) acc += (UINTN)(wt[k + R]) * CONVERT_UINTN(VLOADN(0, src + clamp(y + k, 0, h - 1) * w + x));
        VSTOREN(CONVERT_UCHARN((acc + 32768u) >> 16), 0, dst + y * w + x);
    } else {
        for (int i = 0; x + i < w; i++) {
            uint acc = 0;
            for (int k = -R; k <= R; k++) acc += wt[k + R] * src[clamp(y + k, 0, h - 1) * w + x + i];
            dst[y * w + x + i] = (uchar)((acc + 32768u) >> 16);
        }
    }
}

__kernel void blur_h_f32(__global const uchar* src, __global float* dst, __constant float* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    __global const uchar* row = src + y * w;
    float acc = 0.0f;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * (float)row[clamp(x + k, 0, w - 1)];
    dst[y * w + x] = acc;
}

__kernel void blur_v_f32(__global const float* src, __global uchar* dst, __constant float* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    float acc = 0.0f;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * src[clamp(y + k, 0, h - 1) * w + x];
    dst[y * w + x] = convert_uchar_sat_rte(acc);
}

__kernel void blur_h_f16(__global const uchar* src, __global half* dst, __constant float* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    __global const uchar* row = src + y * w;
    float acc = 0.0f;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * (float)row[clamp(x + k, 0, w - 1)];
    vstore_half(acc, y * w + x, dst);
}

__kernel void blur_v_f16(__global const half* src, __global uchar* dst, __constant float* wt, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    float acc = 0.0f;
    for (int k = -R; k <= R; k++) acc += wt[k + R] * vload_half(clamp(y + k, 0, h - 1) * w + x, src);
    dst[y * w + x] = convert_uchar_sat_rte(acc);
}

__kernel void fill_u8(__global uchar* dst, int offset, int n, uchar value) {
    int i = get_global_id(0) * 4;
    if (i + 4 <= n) {
        vstore4((uchar4)(value), 0, dst + offset + i);
    } else {
        for (; i < n; i++) dst[offset + i] = value;
    }
}

#define PUPIL_BELOW 40
#define GLINT_ABOVE 230

inline uint at(__global const uchar* s, int w, int h, int x, int y) {
    return s[clamp(y, 0, h - 1) * w + clamp(x, 0, w - 1)];
}

__kernel void erode(__global const uchar* src, __global uchar* dst, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    int all = 1;
    for (int dy = -1; dy <= 1; dy++)
        for (int dx = -1; dx <= 1; dx++) all &= at(src, w, h, x + dx, y + dy) < PUPIL_BELOW;
    dst[y * w + x] = all ? 255 : 0;
}

__kernel void dilate(__global const uchar* src, __global uchar* dst, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    uint any = 0;
    for (int dy = -1; dy <= 1; dy++)
        for (int dx = -1; dx <= 1; dx++) any |= at(src, w, h, x + dx, y + dy);
    dst[y * w + x] = any ? 255 : 0;
}

__kernel void sobel(__global const uchar* src, __global uchar* dst, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    int gx = (int)at(src, w, h, x + 1, y - 1) + 2 * (int)at(src, w, h, x + 1, y) + (int)at(src, w, h, x + 1, y + 1)
           - (int)at(src, w, h, x - 1, y - 1) - 2 * (int)at(src, w, h, x - 1, y) - (int)at(src, w, h, x - 1, y + 1);
    int gy = (int)at(src, w, h, x - 1, y + 1) + 2 * (int)at(src, w, h, x, y + 1) + (int)at(src, w, h, x + 1, y + 1)
           - (int)at(src, w, h, x - 1, y - 1) - 2 * (int)at(src, w, h, x, y - 1) - (int)at(src, w, h, x + 1, y - 1);
    dst[y * w + x] = (uchar)min(abs(gx) + abs(gy), 255);
}

__kernel void clear_u32(__global uint* dst, int n) {
    int i = get_global_id(0);
    if (i < n) dst[i] = 0;
}

__kernel void histogram_global(__global const uchar* src, __global uint* bins, int n) {
    int i = get_global_id(0);
    if (i < n) atomic_inc(&bins[src[i]]);
}

// One histogram per work-group in local memory, added to the global one at the end.
__kernel void histogram_local(__global const uchar* src, __global uint* bins, int n) {
    __local uint local_bins[256];
    int lid = get_local_id(0), size = get_local_size(0);
    for (int b = lid; b < 256; b += size) local_bins[b] = 0;
    barrier(CLK_LOCAL_MEM_FENCE);
    for (int i = get_global_id(0); i < n; i += get_global_size(0)) atomic_inc(&local_bins[src[i]]);
    barrier(CLK_LOCAL_MEM_FENCE);
    for (int b = lid; b < 256; b += size) if (local_bins[b]) atomic_add(&bins[b], local_bins[b]);
}

// One work-item per row: pupil count and x sum (from a mask, or gray below the threshold),
// glint count and x sum.
__kernel void moments(__global const uchar* pupil, __global const uchar* glint, __global uint* out, int w, int h, int mask) {
    int y = get_global_id(0);
    if (y >= h) return;
    uint m0 = 0, m1 = 0, m2 = 0, m3 = 0;
    for (int x = 0; x < w; x++) {
        uint p = pupil[y * w + x];
        uint pm = mask ? (p != 0) : (p < PUPIL_BELOW);
        uint gm = glint[y * w + x] > GLINT_ABOVE;
        m0 += pm;
        m1 += pm * x;
        m2 += gm;
        m3 += gm * x;
    }
    vstore4((uint4)(m0, m1, m2, m3), y, out);
}

// ---- general kernels ----

#define GEMM_TILE 16
#define GEMM(T, name, tiled)                                                                     \
__kernel void name(__global const T* a, __global const T* b, __global T* c, int n) {             \
    int j = get_global_id(0), i = get_global_id(1);                                              \
    if (i >= n || j >= n) return;                                                                \
    T acc = 0;                                                                                    \
    for (int k = 0; k < n; k++) acc += a[i * n + k] * b[k * n + j];                              \
    c[i * n + j] = acc;                                                                          \
}                                                                                                \
__kernel __attribute__((reqd_work_group_size(GEMM_TILE, GEMM_TILE, 1)))                          \
void tiled(__global const T* a, __global const T* b, __global T* c, int n) {                     \
    __local T as[GEMM_TILE][GEMM_TILE], bs[GEMM_TILE][GEMM_TILE];                                \
    int lx = get_local_id(0), ly = get_local_id(1);                                              \
    int j = get_global_id(0), i = get_global_id(1);                                              \
    T acc = 0;                                                                                    \
    for (int t = 0; t < n; t += GEMM_TILE) {                                                     \
        as[ly][lx] = a[i * n + t + lx];                                                          \
        bs[ly][lx] = b[(t + ly) * n + j];                                                        \
        barrier(CLK_LOCAL_MEM_FENCE);                                                            \
        for (int k = 0; k < GEMM_TILE; k++) acc += as[ly][k] * bs[k][lx];                        \
        barrier(CLK_LOCAL_MEM_FENCE);                                                            \
    }                                                                                            \
    c[i * n + j] = acc;                                                                          \
}
GEMM(float, gemm_f32, gemm_f32_tiled)
GEMM(int, gemm_i32, gemm_i32_tiled)

// A tree in local memory per work-group, then one atomic add per group.
__kernel void reduce_u32(__global const uint* src, __global uint* out, int n, __local uint* part) {
    int lid = get_local_id(0), size = get_local_size(0);
    uint acc = 0;
    for (int i = get_global_id(0); i < n; i += get_global_size(0)) acc += src[i];
    part[lid] = acc;
    barrier(CLK_LOCAL_MEM_FENCE);
    for (int s = size / 2; s > 0; s >>= 1) {
        if (lid < s) part[lid] += part[lid + s];
        barrier(CLK_LOCAL_MEM_FENCE);
    }
    if (lid == 0) atomic_add(out, part[0]);
}

#define MANDEL_ITERS 256
__kernel void mandelbrot(__global uchar* dst, int w, int h) {
    int x = get_global_id(0), y = get_global_id(1);
    if (x >= w || y >= h) return;
    int cr = -2 * 4096 + (x * 3 * 4096) / w;
    int ci = -4096 - 512 + (y * 9 * 512) / h;
    int zr = 0, zi = 0, it = 0;
    while (it < MANDEL_ITERS) {
        int zr2 = zr * zr, zi2 = zi * zi;
        if (zr2 + zi2 > (4 << 24)) break;
        int zri = zr * zi;
        zi = (zri >> 11) + ci;
        zr = ((zr2 - zi2) >> 12) + cr;
        it++;
    }
    dst[y * w + x] = (uchar)min(it, 255);
}

#define ALU_ROUNDS 256
__kernel void alu_u32(__global const uint* src, __global uint* dst, int n) {
    int i = get_global_id(0);
    if (i >= n) return;
    uint x = src[i];
    for (int r = 0; r < ALU_ROUNDS; r++) x = x * 1664525u + 1013904223u;
    dst[i] = x;
}

__kernel void alu_f32(__global const uint* src, __global float* dst, int n) {
    int i = get_global_id(0);
    if (i >= n) return;
    float x = (float)(src[i] % 1024u) / 1024.0f;
    for (int r = 0; r < ALU_ROUNDS; r++) x = x * 0.999f + 0.001f;
    dst[i] = x;
}

// One compare-exchange step of a bitonic network over data[0..n).
__kernel void bitonic(__global uint* data, int j, int k) {
    uint i = get_global_id(0);
    uint l = i ^ (uint)j;
    if (l <= i) return;
    uint a = data[i], b = data[l];
    int ascending = (i & (uint)k) == 0;
    if ((a > b) == ascending) {
        data[i] = b;
        data[l] = a;
    }
}

__kernel void empty(void) {}

__kernel void copy_u32x4(__global const uint4* src, __global uint4* dst) {
    dst[get_global_id(0)] = src[get_global_id(0)];
}
