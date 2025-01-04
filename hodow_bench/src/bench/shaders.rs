//! The kernels GLES and Vulkan run, written once in WGSL and compiled by `naga`: to SPIR-V
//! for Vulkan, to GLSL ES 3.10 for GLES, whose driver then compiles that itself - so its
//! compiler is part of what is timed, as with OpenCL C.
//!
//! Neither API has 8- or 16-bit storage here, so images live packed in `u32` words: four
//! gray pixels, or two 16-bit values (Bayer photosites, horizontal blur sums). An invocation
//! therefore produces whole words, at least four pixels. Every task becomes a [`Plan`] -
//! buffers and launches - that both backends execute the same way.

use super::data::{as_bytes, bayer_rg10, gaussian_weights, gemm_inputs, gray_u8, random_bytes, u32_bytes, words};
use super::spec::{RowStatus, Task, Variant};

pub type Refusal = (RowStatus, String);

/// Workgroup width of every row-oriented kernel; a row is `y`, so groups are one row tall.
const WX: u32 = 64;
/// The local-memory variant's tiles: the horizontal pass a row of `LOCAL_H` invocations, the
/// vertical one `LOCAL_V` - small enough for GLES 3.1's guaranteed 16 KB at radius 32.
const LOCAL_H: [u32; 2] = [64, 1];
const LOCAL_V: [u32; 2] = [8, 8];

const COMMON: &str = "
struct P { w: u32, h: u32, a: u32, b: u32 }
@group(0) @binding(0) var<uniform> p: P;
@group(0) @binding(1) var<storage, read> src: array<u32>;
@group(0) @binding(2) var<storage, read_write> dst: array<$DST>;
@group(0) @binding(3) var<storage, read> wt: array<u32>;
@group(0) @binding(4) var<storage, read> aux: array<u32>;
const R: i32 = $R;
const TAPS: u32 = $TAPS;
const VN: u32 = $VN;

// Gray pixel x of row y, clamped to the row; four per word.
fn px(y: u32, x: i32) -> u32 {
    let xc = u32(clamp(x, 0, i32(p.w) - 1));
    return (src[y * (p.w / 4u) + xc / 4u] >> (8u * (xc % 4u))) & 0xFFu;
}

// Horizontal sum at column x of row y, clamped to the image; two per word.
fn hs(y: i32, x: u32) -> u32 {
    let yc = u32(clamp(y, 0, i32(p.h) - 1));
    return (src[yc * (p.w / 2u) + x / 2u] >> (16u * (x % 2u))) & 0xFFFFu;
}

// Gray pixel (x, y) of src, both clamped.
fn at(x: i32, y: i32) -> u32 {
    return px(u32(clamp(y, 0, i32(p.h) - 1)), x);
}

fn luma(a: u32, b: u32) -> u32 {
    return (77u * (a & 0xFFFFu) + 75u * ((a >> 16u) + (b & 0xFFFFu)) + 29u * (b >> 16u)) >> 10u;
}
";

/// p.w, p.h = output size. VN pixels (VN / 4 words) per invocation.
const DEBAYER: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    let y = g.y;
    if (y >= p.h) { return; }
    for (var j = 0u; j < VN / 4u; j++) {
        let wi = g.x * (VN / 4u) + j;
        if (wi >= words) { break; }
        var out = 0u;
        for (var i = 0u; i < 4u; i++) {
            let x = wi * 4u + i;
            out |= luma(src[2u * y * p.w + x], src[(2u * y + 1u) * p.w + x]) << (8u * i);
        }
        dst[y * words + wi] = out;
    }
}
";

/// Gray in, horizontal sums out, two per word; VN pixels per invocation.
const BLUR_H: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let pairs = p.w / 2u;
    let y = g.y;
    if (y >= p.h) { return; }
    for (var j = 0u; j < VN / 2u; j++) {
        let pw = g.x * (VN / 2u) + j;
        if (pw >= pairs) { break; }
        var out = 0u;
        for (var i = 0u; i < 2u; i++) {
            let x = i32(pw * 2u + i);
            var acc = 0u;
            for (var k = 0u; k < TAPS; k++) { acc += wt[k] * px(y, x + i32(k) - R); }
            out |= acc << (16u * i);
        }
        dst[y * pairs + pw] = out;
    }
}
";

/// Horizontal sums in, gray out; each tap reads the two words holding four sums.
const BLUR_V: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    let y = i32(g.y);
    if (g.y >= p.h) { return; }
    for (var j = 0u; j < VN / 4u; j++) {
        let wi = g.x * (VN / 4u) + j;
        if (wi >= words) { break; }
        var acc = vec4<u32>(0u);
        for (var k = 0u; k < TAPS; k++) {
            let yc = u32(clamp(y + i32(k) - R, 0, i32(p.h) - 1));
            let a = src[yc * (p.w / 2u) + wi * 2u];
            let b = src[yc * (p.w / 2u) + wi * 2u + 1u];
            acc += wt[k] * vec4<u32>(a & 0xFFFFu, a >> 16u, b & 0xFFFFu, b >> 16u);
        }
        let v = (acc + vec4<u32>(32768u)) >> vec4<u32>(16u);
        dst[g.y * words + wi] = v.x | (v.y << 8u) | (v.z << 16u) | (v.w << 24u);
    }
}
";

/// The full window per pixel, four pixels per invocation.
const BLUR_NAIVE: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    let wi = g.x;
    if (wi >= words || g.y >= p.h) { return; }
    var out = 0u;
    for (var i = 0u; i < 4u; i++) {
        let x = i32(wi * 4u + i);
        var acc = 0u;
        for (var j = 0u; j < TAPS; j++) {
            let yy = u32(clamp(i32(g.y) + i32(j) - R, 0, i32(p.h) - 1));
            var s = 0u;
            for (var k = 0u; k < TAPS; k++) { s += wt[k] * px(yy, x + i32(k) - R); }
            acc += wt[j] * s;
        }
        out |= ((acc + 32768u) >> 16u) << (8u * i);
    }
    dst[g.y * words + wi] = out;
}
";

/// A row of LOCAL_H invocations stages its 4 * LOCAL_H pixels and both halos in shared
/// memory, then each sums four pixels out of it. No early return before the barrier.
const BLUR_H_LOCAL: &str = "
const TILE: u32 = $TILE;
var<workgroup> tile: array<u32, TILE>;
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(local_invocation_id) l: vec3<u32>, @builtin(workgroup_id) wg: vec3<u32>) {
    let y = min(wg.y, p.h - 1u);
    let x0 = i32(wg.x * 4u * $WXu) - R;
    for (var i = l.x; i < TILE; i += $WXu) { tile[i] = px(y, x0 + i32(i)); }
    workgroupBarrier();
    let pw0 = (wg.x * $WXu + l.x) * 2u;
    if (wg.y < p.h) {
        for (var j = 0u; j < 2u; j++) {
            let pw = pw0 + j;
            if (pw < p.w / 2u) {
                var out = 0u;
                for (var i = 0u; i < 2u; i++) {
                    let base = l.x * 4u + j * 2u + i;
                    var acc = 0u;
                    for (var k = 0u; k < TAPS; k++) { acc += wt[k] * tile[base + k]; }
                    out |= acc << (16u * i);
                }
                dst[wg.y * (p.w / 2u) + pw] = out;
            }
        }
    }
}
";

/// LOCAL_V columns-of-four by LOCAL_V rows stage the sums they need, halo rows included.
const BLUR_V_LOCAL: &str = "
const COLS: u32 = 4u * $WXu;
const ROWS: u32 = $WYu + 2u * u32(R);
var<workgroup> tile: array<u32, $TILE>;
@compute @workgroup_size($WX, $WY, 1)
fn main(@builtin(local_invocation_id) l: vec3<u32>, @builtin(workgroup_id) wg: vec3<u32>) {
    let words = p.w / 4u;
    let wi = min(wg.x * $WXu + l.x, words - 1u);
    let y0 = i32(wg.y * $WYu) - R;
    for (var r = l.y; r < ROWS; r += $WYu) {
        for (var i = 0u; i < 4u; i++) { tile[r * COLS + l.x * 4u + i] = hs(y0 + i32(r), wi * 4u + i); }
    }
    workgroupBarrier();
    let y = wg.y * $WYu + l.y;
    if (wg.x * $WXu + l.x < words && y < p.h) {
        var out = 0u;
        for (var i = 0u; i < 4u; i++) {
            var acc = 0u;
            for (var k = 0u; k < TAPS; k++) { acc += wt[k] * tile[(l.y + k) * COLS + l.x * 4u + i]; }
            out |= ((acc + 32768u) >> 16u) << (8u * i);
        }
        dst[y * words + wi] = out;
    }
}
";

/// p.w words from p.a on are set to p.b.
const FILL: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    if (g.x < p.w) { dst[p.a + g.x] = p.b; }
}
";

/// p.w words, four per invocation.
const COPY: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    for (var i = 0u; i < 4u; i++) {
        let w = g.x * 4u + i;
        if (w < p.w) { dst[w] = src[w]; }
    }
}
";

/// Threshold and 3x3 erosion (p.a = 0) or 3x3 dilation (p.a = 1), four pixels per invocation.
const MORPH: &str = "
const PUPIL_BELOW: u32 = 40u;
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    if (g.x >= words || g.y >= p.h) { return; }
    var out = 0u;
    for (var i = 0u; i < 4u; i++) {
        let x = i32(g.x * 4u + i);
        var every = true;
        var some = false;
        for (var dy = -1; dy <= 1; dy++) {
            for (var dx = -1; dx <= 1; dx++) {
                let v = at(x + dx, i32(g.y) + dy);
                every = every && v < PUPIL_BELOW;
                some = some || v != 0u;
            }
        }
        let on = select(some, every, p.a == 0u);
        out |= select(0u, 255u, on) << (8u * i);
    }
    dst[g.y * words + g.x] = out;
}
";

const SOBEL: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    if (g.x >= words || g.y >= p.h) { return; }
    let y = i32(g.y);
    var out = 0u;
    for (var i = 0u; i < 4u; i++) {
        let x = i32(g.x * 4u + i);
        let gx = i32(at(x + 1, y - 1)) + 2 * i32(at(x + 1, y)) + i32(at(x + 1, y + 1)) - i32(at(x - 1, y - 1)) - 2 * i32(at(x - 1, y)) - i32(at(x - 1, y + 1));
        let gy = i32(at(x - 1, y + 1)) + 2 * i32(at(x, y + 1)) + i32(at(x + 1, y + 1)) - i32(at(x - 1, y - 1)) - 2 * i32(at(x, y - 1)) - i32(at(x + 1, y - 1));
        out |= u32(min(abs(gx) + abs(gy), 255)) << (8u * i);
    }
    dst[g.y * words + g.x] = out;
}
";

/// p.w words of pixels, every pixel an atomic add on the global bins.
const HISTOGRAM_GLOBAL: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    if (g.x >= p.w) { return; }
    let v = src[g.x];
    for (var i = 0u; i < 4u; i++) { atomicAdd(&dst[(v >> (8u * i)) & 0xFFu], 1u); }
}
";

/// Each workgroup strides over the words into its own bins, then adds them to the global ones.
const HISTOGRAM_LOCAL: &str = "
var<workgroup> bins: array<atomic<u32>, 256>;
@compute @workgroup_size(256, 1, 1)
fn main(@builtin(local_invocation_id) l: vec3<u32>, @builtin(global_invocation_id) g: vec3<u32>, @builtin(num_workgroups) n: vec3<u32>) {
    atomicStore(&bins[l.x], 0u);
    workgroupBarrier();
    for (var w = g.x; w < p.w; w += n.x * 256u) {
        let v = src[w];
        for (var i = 0u; i < 4u; i++) { atomicAdd(&bins[(v >> (8u * i)) & 0xFFu], 1u); }
    }
    workgroupBarrier();
    let c = atomicLoad(&bins[l.x]);
    if (c != 0u) { atomicAdd(&dst[l.x], c); }
}
";

/// One invocation per row. Pupil from src (p.a = 1: a mask, 0: gray below the threshold),
/// glints from aux.
const MOMENTS: &str = "
const PUPIL_BELOW: u32 = 40u;
const GLINT_ABOVE: u32 = 230u;
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let y = g.x;
    if (y >= p.h) { return; }
    let words = p.w / 4u;
    var m = vec4<u32>(0u);
    for (var wi = 0u; wi < words; wi++) {
        let pv = src[y * words + wi];
        let gv = aux[y * words + wi];
        for (var i = 0u; i < 4u; i++) {
            let x = wi * 4u + i;
            let pp = (pv >> (8u * i)) & 0xFFu;
            let pm = select(u32(pp < PUPIL_BELOW), u32(pp != 0u), p.a == 1u);
            let gm = u32(((gv >> (8u * i)) & 0xFFu) > GLINT_ABOVE);
            m += vec4<u32>(pm, pm * x, gm, gm * x);
        }
    }
    dst[y * 4u] = m.x;
    dst[y * 4u + 1u] = m.y;
    dst[y * 4u + 2u] = m.z;
    dst[y * 4u + 3u] = m.w;
}
";

/// C = A B, one element per invocation; A in src, B in aux, n in p.w, f32 when p.a = 1.
const GEMM: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let n = p.w;
    let j = g.x;
    let i = g.y;
    if (i >= n || j >= n) { return; }
    if (p.a == 1u) {
        var acc = 0.0;
        for (var k = 0u; k < n; k++) { acc += bitcast<f32>(src[i * n + k]) * bitcast<f32>(aux[k * n + j]); }
        dst[i * n + j] = bitcast<u32>(acc);
    } else {
        var acc = 0i;
        for (var k = 0u; k < n; k++) { acc += bitcast<i32>(src[i * n + k]) * bitcast<i32>(aux[k * n + j]); }
        dst[i * n + j] = bitcast<u32>(acc);
    }
}
";

/// The same, through 16x16 tiles of A and B in workgroup memory.
const GEMM_TILED: &str = "
var<workgroup> ta: array<u32, 256>;
var<workgroup> tb: array<u32, 256>;
@compute @workgroup_size(16, 16, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>, @builtin(local_invocation_id) l: vec3<u32>) {
    let n = p.w;
    let j = g.x;
    let i = g.y;
    var accf = 0.0;
    var acci = 0i;
    for (var t = 0u; t < n; t += 16u) {
        ta[l.y * 16u + l.x] = src[i * n + t + l.x];
        tb[l.y * 16u + l.x] = aux[(t + l.y) * n + j];
        workgroupBarrier();
        for (var k = 0u; k < 16u; k++) {
            let a = ta[l.y * 16u + k];
            let b = tb[k * 16u + l.x];
            accf += bitcast<f32>(a) * bitcast<f32>(b);
            acci += bitcast<i32>(a) * bitcast<i32>(b);
        }
        workgroupBarrier();
    }
    dst[i * n + j] = select(bitcast<u32>(acci), bitcast<u32>(accf), p.a == 1u);
}
";

/// A strided sum per invocation, a tree in workgroup memory, one atomic add per group.
const REDUCE: &str = "
var<workgroup> part: array<u32, 256>;
@compute @workgroup_size(256, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>, @builtin(local_invocation_id) l: vec3<u32>, @builtin(num_workgroups) nw: vec3<u32>) {
    var acc = 0u;
    for (var i = g.x; i < p.w; i += nw.x * 256u) { acc += src[i]; }
    part[l.x] = acc;
    workgroupBarrier();
    for (var s = 128u; s > 0u; s >>= 1u) {
        if (l.x < s) { part[l.x] += part[l.x + s]; }
        workgroupBarrier();
    }
    if (l.x == 0u) { atomicAdd(&dst[0], part[0]); }
}
";

/// Four pixels per invocation, 12-bit fixed point.
const MANDELBROT: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    if (g.x >= words || g.y >= p.h) { return; }
    var out = 0u;
    for (var q = 0u; q < 4u; q++) {
        let x = i32(g.x * 4u + q);
        let cr = -2 * 4096 + (x * 3 * 4096) / i32(p.w);
        let ci = -4096 - 512 + (i32(g.y) * 9 * 512) / i32(p.h);
        var zr = 0i;
        var zi = 0i;
        var it = 0u;
        loop {
            if (it >= 256u) { break; }
            let zr2 = zr * zr;
            let zi2 = zi * zi;
            if (zr2 + zi2 > (4 << 24u)) { break; }
            let zri = zr * zi;
            zi = (zri >> 11u) + ci;
            zr = ((zr2 - zi2) >> 12u) + cr;
            it++;
        }
        out |= min(it, 255u) << (8u * q);
    }
    dst[g.y * words + g.x] = out;
}
";

const ALU: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let i = g.x + g.y * 65535u * $WXu;
    if (i >= p.w) { return; }
    if (p.a == 1u) {
        var x = f32(src[i] % 1024u) / 1024.0;
        for (var r = 0u; r < 256u; r++) { x = x * 0.999 + 0.001; }
        dst[i] = bitcast<u32>(x);
    } else {
        var x = src[i];
        for (var r = 0u; r < 256u; r++) { x = x * 1664525u + 1013904223u; }
        dst[i] = x;
    }
}
";

/// One compare-exchange step of a bitonic network, in place: p.a = j, p.b = k.
const BITONIC: &str = "
@compute @workgroup_size($WX, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let i = g.x + g.y * 65535u * $WXu;
    if (i >= p.w) { return; }
    let l = i ^ p.a;
    if (l <= i) { return; }
    let a = dst[i];
    let b = dst[l];
    let ascending = (i & p.b) == 0u;
    if ((a > b) == ascending) {
        dst[i] = b;
        dst[l] = a;
    }
}
";

const EMPTY: &str = "
@compute @workgroup_size(1, 1, 1)
fn main() {}
";

/// Horizontal pass, four pixels (one input word) per invocation, generated for one radius:
/// the 2A + 1 words around them loaded once, every tap a literal weight times a byte of
/// them. Invocations whose window would leave the row take the clamped path instead.
fn unrolled_h(weights: &[u16]) -> String {
    let r = weights.len() / 2;
    let a = r.div_ceil(4);
    let mut s = String::from(
        "
@compute @workgroup_size(64, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    let wi = g.x;
    let y = g.y;
    if (wi >= words || y >= p.h) { return; }
    var acc = vec4<u32>(0u);
",
    );
    s.push_str(&format!(
        "    if (wi >= {a}u && wi + {a}u < words) {{
        let row = y * words + wi - {a}u;
"
    ));
    for j in 0..=2 * a {
        s.push_str(&format!(
            "        let w{j} = src[row + {j}u];
"
        ));
    }
    for i in 0..4 {
        let terms: Vec<String> = weights
            .iter()
            .enumerate()
            .filter(|&(_, &w)| w > 0)
            .map(|(k, &w)| {
                let byte = 4 * a + i + k - r;
                format!("{w}u * ((w{} >> {}u) & 0xFFu)", byte / 4, 8 * (byte % 4))
            })
            .collect();
        s.push_str(&format!(
            "        acc[{i}] = {};
",
            terms.join(" + ")
        ));
    }
    s.push_str(
        "    } else {
",
    );
    for i in 0..4 {
        let terms: Vec<String> = weights
            .iter()
            .enumerate()
            .filter(|&(_, &w)| w > 0)
            .map(|(k, &w)| format!("{w}u * px(y, i32(wi * 4u) + {})", i + k as i32 - r as i32))
            .collect();
        s.push_str(&format!(
            "        acc[{i}] = {};
",
            terms.join(" + ")
        ));
    }
    s.push_str(
        "    }
    dst[y * (p.w / 2u) + wi * 2u] = acc.x | (acc.y << 16u);
    dst[y * (p.w / 2u) + wi * 2u + 1u] = acc.z | (acc.w << 16u);
}
",
    );
    s
}

/// Vertical pass, four pixels per invocation: two words per tap row, literal weights, rows
/// clamped only for invocations near the top or bottom.
fn unrolled_v(weights: &[u16]) -> String {
    let r = weights.len() / 2;
    let mut s = String::from(
        "
fn sums(row: u32, wi: u32) -> vec4<u32> {
    let a = src[row * (p.w / 2u) + wi * 2u];
    let b = src[row * (p.w / 2u) + wi * 2u + 1u];
    return vec4<u32>(a & 0xFFFFu, a >> 16u, b & 0xFFFFu, b >> 16u);
}

@compute @workgroup_size(64, 1, 1)
fn main(@builtin(global_invocation_id) g: vec3<u32>) {
    let words = p.w / 4u;
    let wi = g.x;
    let y = g.y;
    if (wi >= words || y >= p.h) { return; }
    var acc = vec4<u32>(0u);
",
    );
    let rows = |clamped: bool| -> String {
        weights
            .iter()
            .enumerate()
            .filter(|&(_, &w)| w > 0)
            .map(|(k, &w)| {
                let off = k as i32 - r as i32;
                let row = if clamped {
                    format!("u32(clamp(i32(y) + {off}, 0, i32(p.h) - 1))")
                } else {
                    format!("u32(i32(y) + {off})")
                };
                format!(
                    "        acc += {w}u * sums({row}, wi);
"
                )
            })
            .collect()
    };
    s.push_str(&format!(
        "    if (y >= {r}u && y + {r}u < p.h) {{
{}    }} else {{
{}    }}
",
        rows(false),
        rows(true)
    ));
    s.push_str(
        "    let v = (acc + vec4<u32>(32768u)) >> vec4<u32>(16u);
    dst[y * words + wi] = v.x | (v.y << 8u) | (v.z << 16u) | (v.w << 24u);
}
",
    );
    s
}

fn source(body: &str, radius: usize, vn: u32, wg: [u32; 2], tile: u32) -> String {
    let mut s = String::from(COMMON);
    s.push_str(body);
    let dst = if body.contains("atomicAdd(&dst[") {
        "atomic<u32>"
    } else {
        "u32"
    };
    s.replace("$DST", dst)
        .replace("$TAPS", &format!("{}u", 2 * radius + 1))
        .replace("$R", &radius.to_string())
        .replace("$VN", &format!("{vn}u"))
        .replace("$TILE", &format!("{tile}u"))
        .replace("$WX", &wg[0].to_string())
        .replace("$WY", &wg[1].to_string())
}

/// One kernel launch: what it binds and how many workgroups.
pub struct Launch {
    pub source: String,
    pub params: [u32; 4],
    pub src: usize,
    pub dst: usize,
    /// A second input, bound as `aux`; 0 (the placeholder) when unused.
    pub aux: usize,
    pub groups: [u32; 3],
}

/// Buffers by index: 0 is a placeholder for unused bindings, 1 the weights.
pub struct Plan {
    pub buffers: Vec<Vec<u8>>,
    pub input: Option<usize>,
    pub output: Option<usize>,
    /// How many bytes of the output buffer are the result.
    pub output_len: usize,
    pub launches: Vec<Launch>,
    /// Upload and download happen each frame; kernels-only tasks skip both.
    pub transfers: (bool, bool),
}

/// A one-dimensional launch of `n` invocations folded into y once x would pass the 65535
/// workgroups every API guarantees; the kernel recombines them as g.x + g.y * 65535 * WX.
fn spread(mut launch: Launch, n: u32) -> Launch {
    let groups = n.div_ceil(WX);
    launch.groups = [groups.min(65535), groups.div_ceil(65535), 1];
    launch
}

fn padded(bytes: Vec<u8>) -> Vec<u8> {
    let mut bytes = bytes;
    bytes.resize(bytes.len().next_multiple_of(4).max(4), 0);
    bytes
}

/// Pixels per invocation of each variant; the rest are not written for packed storage.
fn lanes(variant: Variant) -> Result<u32, Refusal> {
    match variant {
        Variant::Naive | Variant::Vec4 | Variant::Local | Variant::Unrolled => Ok(4),
        Variant::Vec8 => Ok(8),
        Variant::Vec16 => Ok(16),
        other => Err((
            RowStatus::Unsupported,
            format!("no {other:?} variant over packed 32-bit storage"),
        )),
    }
}

pub fn plan(task: Task, variant: Variant) -> Result<Plan, Refusal> {
    let radius = task.blur_radius().unwrap_or(0) as usize;
    let vn = lanes(variant)?;
    let weights: Vec<u8> = gaussian_weights(radius)
        .iter()
        .flat_map(|&w| u32::from(w).to_le_bytes())
        .collect();
    let mut buffers = vec![vec![0u8; 16], weights];
    let mut add = |bytes: Vec<u8>| {
        buffers.push(padded(bytes));
        buffers.len() - 1
    };
    let mut launches = Vec::new();
    let row = |body: &str, params: [u32; 4], src, dst, units: u32, rows: u32| Launch {
        source: source(body, radius, vn, [WX, 1], 0),
        params,
        src,
        dst,
        aux: 0,
        groups: [units.div_ceil(WX).max(1), rows.max(1), 1],
    };
    let aligned = |w: u32, what: &str| {
        if w.is_multiple_of(4) {
            Ok(())
        } else {
            Err((
                RowStatus::Unsupported,
                format!("{what} width {w} is not a multiple of 4"),
            ))
        }
    };
    // Gray (w x h, buffer `gray`) -> blur -> `out`, in the variant's shape.
    let blur =
        |launches: &mut Vec<Launch>, add: &mut dyn FnMut(Vec<u8>) -> usize, gray: usize, out: usize, w: u32, h: u32| {
            let per = |n: u32| w.div_ceil(n);
            if variant == Variant::Naive {
                launches.push(row(BLUR_NAIVE, [w, h, 0, 0], gray, out, per(4), h));
                return;
            }
            let sums = add(vec![0; (w * h * 2) as usize]);
            if variant == Variant::Unrolled {
                let weights = gaussian_weights(radius);
                for (body, src, dst) in [(unrolled_h(&weights), gray, sums), (unrolled_v(&weights), sums, out)] {
                    launches.push(Launch {
                        source: source(&body, radius, vn, [WX, 1], 0),
                        params: [w, h, 0, 0],
                        src,
                        dst,
                        aux: 0,
                        groups: [(w / 4).div_ceil(64), h, 1],
                    });
                }
                return;
            }
            if variant == Variant::Local {
                let tile_h = 4 * LOCAL_H[0] + 2 * radius as u32;
                launches.push(Launch {
                    source: source(BLUR_H_LOCAL, radius, vn, LOCAL_H, tile_h),
                    params: [w, h, 0, 0],
                    src: gray,
                    dst: sums,
                    aux: 0,
                    groups: [w.div_ceil(4 * LOCAL_H[0]), h, 1],
                });
                let tile_v = (LOCAL_V[1] + 2 * radius as u32) * 4 * LOCAL_V[0];
                launches.push(Launch {
                    source: source(BLUR_V_LOCAL, radius, vn, LOCAL_V, tile_v),
                    params: [w, h, 0, 0],
                    src: sums,
                    dst: out,
                    aux: 0,
                    groups: [(w / 4).div_ceil(LOCAL_V[0]), h.div_ceil(LOCAL_V[1]), 1],
                });
                return;
            }
            launches.push(row(BLUR_H, [w, h, 0, 0], gray, sums, per(vn), h));
            launches.push(row(BLUR_V, [w, h, 0, 0], sums, out, per(vn), h));
        };
    let (input, output, output_len, transfers) = match task {
        Task::Debayer { width, height } => {
            let (ow, oh) = (width / 2, height / 2);
            aligned(ow, "output")?;
            let input = add(as_bytes(&bayer_rg10(width, height)).to_vec());
            let output = add(vec![0; (ow * oh) as usize]);
            launches.push(row(DEBAYER, [ow, oh, 0, 0], input, output, ow.div_ceil(vn), oh));
            (Some(input), Some(output), (ow * oh) as usize, (true, true))
        }
        Task::Blur { width, height, .. } => {
            aligned(width, "image")?;
            let input = add(gray_u8(width, height));
            let output = add(vec![0; (width * height) as usize]);
            blur(&mut launches, &mut add, input, output, width, height);
            (Some(input), Some(output), (width * height) as usize, (true, true))
        }
        Task::Pipeline { width, height, .. } => {
            let (ow, oh) = (width / 2, height / 2);
            aligned(ow, "output")?;
            let chroma = ow * oh / 2;
            if chroma % 4 != 0 {
                return Err((
                    RowStatus::Unsupported,
                    format!("chroma plane of {chroma} bytes is not whole words"),
                ));
            }
            let input = add(as_bytes(&bayer_rg10(width, height)).to_vec());
            let gray = add(vec![0; (ow * oh) as usize]);
            let output = add(vec![0; (ow * oh + chroma) as usize]);
            let debayer_vn = if variant == Variant::Vec16 { 16 } else { 4 };
            launches.push(Launch {
                source: source(DEBAYER, radius, debayer_vn, [WX, 1], 0),
                params: [ow, oh, 0, 0],
                src: input,
                dst: gray,
                aux: 0,
                groups: [ow.div_ceil(debayer_vn).div_ceil(WX), oh, 1],
            });
            blur(&mut launches, &mut add, gray, output, ow, oh);
            launches.push(row(
                FILL,
                [chroma / 4, 0, ow * oh / 4, 0x8080_8080],
                0,
                output,
                chroma / 4,
                1,
            ));
            (Some(input), Some(output), (ow * oh + chroma) as usize, (true, true))
        }
        Task::Upload { bytes } => {
            let input = add(random_bytes(bytes as usize));
            (Some(input), None, 0, (true, false))
        }
        Task::Download { bytes } => {
            let output = add(random_bytes(bytes as usize));
            (None, Some(output), bytes as usize, (false, true))
        }
        Task::Dispatch => {
            launches.push(Launch {
                source: source(EMPTY, 0, 4, [1, 1], 0),
                params: [0; 4],
                src: 0,
                dst: 0,
                aux: 0,
                groups: [1, 1, 1],
            });
            (None, None, 0, (false, false))
        }
        Task::Morph { width, height } | Task::Sobel { width, height } => {
            aligned(width, "image")?;
            let input = add(gray_u8(width, height));
            let output = add(vec![0; (width * height) as usize]);
            if matches!(task, Task::Sobel { .. }) {
                launches.push(row(SOBEL, [width, height, 0, 0], input, output, width / 4, height));
            } else {
                let eroded = add(vec![0; (width * height) as usize]);
                launches.push(row(MORPH, [width, height, 0, 0], input, eroded, width / 4, height));
                launches.push(row(MORPH, [width, height, 1, 0], eroded, output, width / 4, height));
            }
            (Some(input), Some(output), (width * height) as usize, (true, true))
        }
        Task::Histogram { width, height } => {
            aligned(width, "image")?;
            let words = width * height / 4;
            let input = add(gray_u8(width, height));
            let output = add(vec![0; 1024]);
            launches.push(row(FILL, [256, 0, 0, 0], 0, output, 256, 1));
            match variant {
                Variant::Local => launches.push(Launch {
                    source: source(HISTOGRAM_LOCAL, 0, 4, [256, 1], 0),
                    params: [words, 0, 0, 0],
                    src: input,
                    dst: output,
                    aux: 0,
                    groups: [64, 1, 1],
                }),
                _ => launches.push(row(HISTOGRAM_GLOBAL, [words, 0, 0, 0], input, output, words, 1)),
            }
            (Some(input), Some(output), 1024, (true, true))
        }
        Task::Moments { width, height } => {
            aligned(width, "image")?;
            let input = add(gray_u8(width, height));
            let output = add(vec![0; height as usize * 16]);
            launches.push(Launch {
                aux: input,
                ..row(MOMENTS, [width, height, 0, 0], input, output, height, 1)
            });
            (Some(input), Some(output), height as usize * 16, (true, true))
        }
        Task::Eye { width, height } => {
            let (w, h) = (width / 2, height / 2);
            aligned(w, "output")?;
            let input = add(as_bytes(&bayer_rg10(width, height)).to_vec());
            let gray = add(vec![0; (w * h) as usize]);
            let blurred = add(vec![0; (w * h) as usize]);
            let mask = add(vec![0; (w * h) as usize]);
            let output = add(vec![0; h as usize * 16]);
            launches.push(row(DEBAYER, [w, h, 0, 0], input, gray, w.div_ceil(vn), h));
            blur(&mut launches, &mut add, gray, blurred, w, h);
            launches.push(row(MORPH, [w, h, 0, 0], blurred, mask, w / 4, h));
            launches.push(row(MORPH, [w, h, 1, 0], mask, gray, w / 4, h));
            launches.push(Launch {
                aux: blurred,
                ..row(MOMENTS, [w, h, 1, 0], gray, output, h, 1)
            });
            (Some(input), Some(output), h as usize * 16, (true, true))
        }
        Task::Gemm { n, float } => {
            let (a, b) = gemm_inputs(n, float);
            let input = add(u32_bytes(&a));
            let bm = add(u32_bytes(&b));
            let output = add(vec![0; (n * n * 4) as usize]);
            let f = u32::from(float);
            match variant {
                Variant::Local => {
                    if !n.is_multiple_of(16) {
                        return Err((RowStatus::Unsupported, "the tiled gemm needs n a multiple of 16".into()));
                    }
                    launches.push(Launch {
                        source: source(GEMM_TILED, 0, 4, [16, 16], 0),
                        params: [n, 0, f, 0],
                        src: input,
                        dst: output,
                        aux: bm,
                        groups: [n / 16, n / 16, 1],
                    });
                }
                _ => launches.push(Launch {
                    aux: bm,
                    ..row(GEMM, [n, 0, f, 0], input, output, n, n)
                }),
            }
            (Some(input), Some(output), (n * n * 4) as usize, (true, true))
        }
        Task::Reduce { n } => {
            let input = add(u32_bytes(&words(n, 21)));
            let output = add(vec![0; 4]);
            launches.push(row(FILL, [1, 0, 0, 0], 0, output, 1, 1));
            launches.push(Launch {
                source: source(REDUCE, 0, 4, [256, 1], 0),
                params: [n, 0, 0, 0],
                src: input,
                dst: output,
                aux: 0,
                groups: [64, 1, 1],
            });
            (Some(input), Some(output), 4, (true, true))
        }
        Task::Mandelbrot { width, height } => {
            aligned(width, "image")?;
            let output = add(vec![0; (width * height) as usize]);
            launches.push(row(MANDELBROT, [width, height, 0, 0], 0, output, width / 4, height));
            (None, Some(output), (width * height) as usize, (false, true))
        }
        Task::Alu { n, float } => {
            let input = add(u32_bytes(&words(n, 31)));
            let output = add(vec![0; n as usize * 4]);
            launches.push(spread(row(ALU, [n, 0, u32::from(float), 0], input, output, n, 1), n));
            (Some(input), Some(output), n as usize * 4, (true, true))
        }
        Task::Sort { n } => {
            if !n.is_power_of_two() {
                return Err((
                    RowStatus::Unsupported,
                    "the bitonic network needs a power of two".into(),
                ));
            }
            let input = add(u32_bytes(&words(n, 41)));
            let output = add(vec![0; n as usize * 4]);
            launches.push(row(COPY, [n, 0, 0, 0], input, output, n.div_ceil(4), 1));
            let mut k = 2;
            while k <= n {
                let mut j = k / 2;
                while j > 0 {
                    launches.push(spread(row(BITONIC, [n, 0, j, k], 0, output, n, 1), n));
                    j /= 2;
                }
                k *= 2;
            }
            (Some(input), Some(output), n as usize * 4, (true, true))
        }
        Task::Cnn { .. } => return Err((RowStatus::Unsupported, "the network runs on TFLite only".into())),
        Task::Copy { bytes } => {
            let input = add(random_bytes(bytes as usize));
            let output = add(vec![0; bytes as usize]);
            let n = (bytes / 4) as u32;
            launches.push(row(COPY, [n, 0, 0, 0], input, output, n.div_ceil(4), 1));
            (Some(input), Some(output), bytes as usize, (false, false))
        }
    };
    Ok(Plan {
        buffers,
        input,
        output,
        output_len,
        launches,
        transfers,
    })
}

fn module(source: &str) -> Result<(naga::Module, naga::valid::ModuleInfo), String> {
    let module = naga::front::wgsl::parse_str(source).map_err(|e| format!("WGSL: {}", e.emit_to_string(source)))?;
    let info = naga::valid::Validator::new(naga::valid::ValidationFlags::all(), naga::valid::Capabilities::empty())
        .validate(&module)
        .map_err(|e| format!("WGSL validation: {}", e.emit_to_string(source)))?;
    Ok((module, info))
}

#[cfg(feature = "vulkan")]
pub fn spirv(source: &str) -> Result<Vec<u32>, String> {
    let (module, info) = module(source)?;
    let options = naga::back::spv::Options {
        lang_version: (1, 0),
        ..Default::default()
    };
    naga::back::spv::write_vec(&module, &info, &options, None).map_err(|e| format!("SPIR-V: {e}"))
}

/// Every `for (init; cond; step) { body }` as `{ init; loop { if (!(cond)) { break; } body step; } }`.
///
/// naga writes a `for` with a step as `bool loop_init = true; while(true) { if (!loop_init)
/// { step } loop_init = false; ... }`, and the board's GLES compiler gets that wrong: the
/// first iteration is lost (a four-word copy loses every fourth word, an LCG its first
/// round). The same loop as a plain `for`, or as this, is compiled correctly; the kernels
/// never `continue`, which is what would make the two forms differ.
#[expect(
    clippy::string_slice,
    reason = "every offset comes from a search of the same string, so it sits on a character boundary"
)]
fn without_for_steps(source: &str) -> String {
    let mut s = source.to_string();
    while let Some(at) = s.find("for (") {
        let header_start = at + "for (".len();
        let mut depth = 1;
        let header_end = header_start
            + s[header_start..]
                .find(|c| {
                    depth += match c {
                        '(' => 1,
                        ')' => -1,
                        _ => 0,
                    };
                    depth == 0
                })
                .expect("for header closes");
        let header = &s[header_start..header_end];
        let parts: Vec<&str> = header.splitn(3, ';').map(str::trim).collect();
        let body_open = header_end + s[header_end..].find('{').expect("for body opens");
        let mut depth = 0;
        let body_close = body_open
            + s[body_open..]
                .find(|c| {
                    depth += match c {
                        '{' => 1,
                        '}' => -1,
                        _ => 0,
                    };
                    depth == 0
                })
                .expect("for body closes");
        let body = &s[body_open + 1..body_close];
        assert!(
            !body.contains("continue"),
            "a `continue` would skip the step once the loop is rewritten"
        );
        let rewritten = format!(
            "{{ {}; loop {{ if (!({})) {{ break; }} {body} {}; }} }}",
            parts[0], parts[1], parts[2]
        );
        s.replace_range(at..=body_close, &rewritten);
    }
    s
}

#[cfg(feature = "bench_gles")]
pub fn glsl_es(source: &str) -> Result<String, String> {
    use naga::back::glsl;
    let (module, info) = module(&without_for_steps(source))?;
    let mut options = glsl::Options {
        version: glsl::Version::new_gles(310),
        writer_flags: glsl::WriterFlags::empty(),
        zero_initialize_workgroup_memory: false,
        ..Default::default()
    };
    for binding in 0..5 {
        options
            .binding_map
            .insert(naga::ResourceBinding { group: 0, binding }, binding as u8);
    }
    let pipeline = glsl::PipelineOptions {
        shader_stage: naga::ShaderStage::Compute,
        entry_point: "main".into(),
        multiview: None,
    };
    let mut out = String::new();
    glsl::Writer::new(
        &mut out,
        &module,
        &info,
        &options,
        &pipeline,
        naga::proc::BoundsCheckPolicies::default(),
    )
    .and_then(|mut w| w.write())
    .map_err(|e| format!("GLSL: {e}"))?;
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_kernel_compiles() {
        for task in [
            Task::Debayer { width: 64, height: 8 },
            Task::Blur {
                width: 64,
                height: 8,
                radius: 3,
            },
            Task::Pipeline {
                width: 64,
                height: 16,
                radius: 32,
            },
            Task::Copy { bytes: 1024 },
            Task::Dispatch,
            Task::Morph { width: 64, height: 8 },
            Task::Sobel { width: 64, height: 8 },
            Task::Histogram { width: 64, height: 8 },
            Task::Moments { width: 64, height: 8 },
            Task::Eye { width: 128, height: 16 },
            Task::Gemm { n: 32, float: true },
            Task::Gemm { n: 32, float: false },
            Task::Reduce { n: 4096 },
            Task::Mandelbrot { width: 64, height: 8 },
            Task::Alu { n: 1024, float: true },
            Task::Sort { n: 1024 },
        ] {
            for variant in [
                Variant::Naive,
                Variant::Vec4,
                Variant::Vec8,
                Variant::Vec16,
                Variant::Local,
                Variant::Unrolled,
            ] {
                for launch in plan(task, variant).unwrap().launches {
                    module(&launch.source).unwrap_or_else(|e| panic!("{task:?} {variant:?}: {e}"));
                    #[cfg(feature = "vulkan")]
                    spirv(&launch.source).unwrap();
                    #[cfg(feature = "bench_gles")]
                    assert!(
                        !glsl_es(&launch.source).unwrap().contains("loop_init"),
                        "{task:?} {variant:?} kept naga's loop_init shape"
                    );
                }
            }
        }
    }
}
