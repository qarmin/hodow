//! `.tflite` models written directly, so benchmarking an NPU needs no TensorFlow and no
//! model files: a minimal FlatBuffers writer and the two graphs the bench times.
//!
//! The writer lays every object after whatever refers to it, which is all FlatBuffers asks
//! of an offset (it must point forward); a vtable sits right before its table.

use super::data::gaussian_weights;

pub enum Field {
    U8(u8),
    I32(i32),
    U32(u32),
    Table(Table),
    Tables(Vec<Table>),
    Bytes(Vec<u8>),
    I32s(Vec<i32>),
    F32s(Vec<f32>),
    I64s(Vec<i64>),
    Str(String),
}

#[derive(Default)]
pub struct Table(Vec<(u16, Field)>);

impl Table {
    pub fn with(mut self, slot: u16, field: Field) -> Table {
        self.0.push((slot, field));
        self
    }
}

struct Writer {
    buf: Vec<u8>,
}

impl Writer {
    fn align(&mut self, to: usize) {
        while !self.buf.len().is_multiple_of(to) {
            self.buf.push(0);
        }
    }

    fn patch(&mut self, at: usize, target: usize) {
        self.buf[at..at + 4].copy_from_slice(&((target - at) as u32).to_le_bytes());
    }

    /// A vector's length word placed so that its elements land aligned to `elem`.
    fn vector_start(&mut self, len: usize, elem: usize) -> usize {
        self.align(4);
        while !(self.buf.len() + 4).is_multiple_of(elem.max(4)) {
            self.buf.push(0);
        }
        let at = self.buf.len();
        self.buf.extend((len as u32).to_le_bytes());
        at
    }

    fn child(&mut self, field: &Field) -> usize {
        match field {
            Field::Table(t) => self.table(t),
            Field::Tables(ts) => {
                let at = self.vector_start(ts.len(), 4);
                let slots: Vec<usize> = (0..ts.len()).map(|i| at + 4 + 4 * i).collect();
                self.buf.extend(std::iter::repeat_n(0, 4 * ts.len()));
                for (t, slot) in ts.iter().zip(slots) {
                    let pos = self.table(t);
                    self.patch(slot, pos);
                }
                at
            }
            Field::Bytes(b) => {
                let at = self.vector_start(b.len(), 16);
                self.buf.extend(b);
                at
            }
            Field::I32s(v) => {
                let at = self.vector_start(v.len(), 4);
                self.buf.extend(v.iter().flat_map(|x| x.to_le_bytes()));
                at
            }
            Field::F32s(v) => {
                let at = self.vector_start(v.len(), 4);
                self.buf.extend(v.iter().flat_map(|x| x.to_le_bytes()));
                at
            }
            Field::I64s(v) => {
                let at = self.vector_start(v.len(), 8);
                self.buf.extend(v.iter().flat_map(|x| x.to_le_bytes()));
                at
            }
            Field::Str(s) => {
                let at = self.vector_start(s.len(), 4);
                self.buf.extend(s.as_bytes());
                self.buf.push(0);
                at
            }
            Field::U8(_) | Field::I32(_) | Field::U32(_) => unreachable!("scalars are inline"),
        }
    }

    /// Vtable, then the table: its soffset, the inline fields, then every child.
    fn table(&mut self, t: &Table) -> usize {
        let mut fields: Vec<&(u16, Field)> = t.0.iter().collect();
        // Widest first keeps every inline field aligned without padding between them.
        fields.sort_by_key(|(_, f)| std::cmp::Reverse(matches!(f, Field::U8(_)) as u8 ^ 1));
        let mut layout = Vec::new();
        let mut size = 4usize;
        for (slot, field) in &fields {
            let width = if matches!(field, Field::U8(_)) { 1 } else { 4 };
            size = size.next_multiple_of(width);
            layout.push((*slot, size));
            size += width;
        }
        let table_size = size.next_multiple_of(4);
        let slots = t.0.iter().map(|(s, _)| *s + 1).max().unwrap_or(0) as usize;
        self.align(2);
        // The table after the vtable must start 4-aligned.
        let vtable_len = 4 + 2 * slots;
        while !(self.buf.len() + vtable_len).is_multiple_of(4) {
            self.buf.extend([0, 0]);
        }
        let vtable = self.buf.len();
        self.buf.extend((vtable_len as u16).to_le_bytes());
        self.buf.extend((table_size as u16).to_le_bytes());
        for slot in 0..slots as u16 {
            let offset = layout.iter().find(|(s, _)| *s == slot).map_or(0, |(_, o)| *o as u16);
            self.buf.extend(offset.to_le_bytes());
        }
        let start = self.buf.len();
        self.buf.extend(((start - vtable) as i32).to_le_bytes());
        self.buf.resize(start + table_size, 0);
        let mut children = Vec::new();
        for ((_, field), (_, offset)) in fields.iter().zip(&layout) {
            let at = start + offset;
            match field {
                Field::U8(v) => self.buf[at] = *v,
                Field::I32(v) => self.buf[at..at + 4].copy_from_slice(&v.to_le_bytes()),
                Field::U32(v) => self.buf[at..at + 4].copy_from_slice(&v.to_le_bytes()),
                child => children.push((at, child)),
            }
        }
        for (at, child) in children {
            let pos = self.child(child);
            self.patch(at, pos);
        }
        start
    }
}

/// The model as bytes, with the `TFL3` identifier after the root offset.
pub fn finish(root: &Table) -> Vec<u8> {
    let mut w = Writer { buf: vec![0; 4] };
    w.buf.extend(b"TFL3");
    let pos = w.table(root);
    w.patch(0, pos);
    w.buf
}

const UINT8: u8 = 3;
const INT32: u8 = 2;
const CONV_2D: i32 = 3;
const DEPTHWISE_CONV_2D: i32 = 4;
const OPTIONS_CONV: u8 = 1;
const OPTIONS_DEPTHWISE: u8 = 2;
const SAME: u8 = 0;
const RELU: u8 = 1;

struct Graph {
    tensors: Vec<Table>,
    buffers: Vec<Table>,
    operators: Vec<Table>,
    codes: Vec<i32>,
}

impl Graph {
    fn new() -> Graph {
        // Buffer 0 is the empty sentinel every model starts with.
        Graph {
            tensors: Vec::new(),
            buffers: vec![Table::default()],
            operators: Vec::new(),
            codes: Vec::new(),
        }
    }

    fn tensor(&mut self, shape: &[i32], ty: u8, scale: f32, zero: i64, data: Option<Vec<u8>>) -> i32 {
        let buffer = self.buffers.len() as u32;
        self.buffers.push(match data {
            Some(d) => Table::default().with(0, Field::Bytes(d)),
            None => Table::default(),
        });
        let quant = Table::default()
            .with(2, Field::F32s(vec![scale]))
            .with(3, Field::I64s(vec![zero]));
        let name = format!("t{}", self.tensors.len());
        self.tensors.push(
            Table::default()
                .with(0, Field::I32s(shape.to_vec()))
                .with(1, Field::U8(ty))
                .with(2, Field::U32(buffer))
                .with(3, Field::Str(name))
                .with(4, Field::Table(quant)),
        );
        self.tensors.len() as i32 - 1
    }

    fn op(&mut self, code: i32, inputs: Vec<i32>, output: i32, options_type: u8, options: Table) {
        let index = match self.codes.iter().position(|&c| c == code) {
            Some(i) => i,
            None => {
                self.codes.push(code);
                self.codes.len() - 1
            }
        };
        self.operators.push(
            Table::default()
                .with(0, Field::U32(index as u32))
                .with(1, Field::I32s(inputs))
                .with(2, Field::I32s(vec![output]))
                .with(3, Field::U8(options_type))
                .with(4, Field::Table(options)),
        );
    }

    fn finish(self, input: i32, output: i32) -> Vec<u8> {
        let codes = self
            .codes
            .iter()
            .map(|&c| {
                Table::default()
                    .with(0, Field::U8(c as u8))
                    .with(2, Field::I32(1))
                    .with(3, Field::I32(c))
            })
            .collect();
        let subgraph = Table::default()
            .with(0, Field::Tables(self.tensors))
            .with(1, Field::I32s(vec![input]))
            .with(2, Field::I32s(vec![output]))
            .with(3, Field::Tables(self.operators));
        finish(
            &Table::default()
                .with(0, Field::U32(3))
                .with(1, Field::Tables(codes))
                .with(2, Field::Tables(vec![subgraph]))
                .with(3, Field::Str("hodow bench".into()))
                .with(4, Field::Tables(self.buffers)),
        )
    }
}

fn depthwise_options(activation: u8, stride: i32) -> Table {
    Table::default()
        .with(0, Field::U8(SAME))
        .with(1, Field::I32(stride))
        .with(2, Field::I32(stride))
        .with(3, Field::I32(1))
        .with(4, Field::U8(activation))
        .with(5, Field::I32(1))
        .with(6, Field::I32(1))
}

/// The bench's gaussian as two uint8 depthwise convolutions, a row then a column, with the
/// same weights (scale 1/256). Radius 0 has a centre weight of 256, which uint8 cannot hold.
pub fn blur(width: u32, height: u32, radius: usize) -> Option<Vec<u8>> {
    if radius == 0 {
        return None;
    }
    let (w, h) = (width as i32, height as i32);
    let weights: Vec<u8> = gaussian_weights(radius).iter().map(|&v| v as u8).collect();
    let taps = weights.len() as i32;
    let mut g = Graph::new();
    let input = g.tensor(&[1, h, w, 1], UINT8, 1.0, 0, None);
    let wh = g.tensor(&[1, 1, taps, 1], UINT8, 1.0 / 256.0, 0, Some(weights.clone()));
    let bh = g.tensor(&[1], INT32, 1.0 / 256.0, 0, Some(vec![0; 4]));
    let mid = g.tensor(&[1, h, w, 1], UINT8, 1.0, 0, None);
    let wv = g.tensor(&[1, taps, 1, 1], UINT8, 1.0 / 256.0, 0, Some(weights));
    let bv = g.tensor(&[1], INT32, 1.0 / 256.0, 0, Some(vec![0; 4]));
    let output = g.tensor(&[1, h, w, 1], UINT8, 1.0, 0, None);
    g.op(
        DEPTHWISE_CONV_2D,
        vec![input, wh, bh],
        mid,
        OPTIONS_DEPTHWISE,
        depthwise_options(0, 1),
    );
    g.op(
        DEPTHWISE_CONV_2D,
        vec![mid, wv, bv],
        output,
        OPTIONS_DEPTHWISE,
        depthwise_options(0, 1),
    );
    Some(g.finish(input, output))
}

fn pseudo(i: usize, seed: u32) -> u8 {
    let mut h = (i as u32).wrapping_mul(0x9E37_79B1) ^ seed.wrapping_mul(0x85EB_CA77);
    h ^= h >> 15;
    h = h.wrapping_mul(0x2C1B_3C6D);
    (h >> 24) as u8
}

/// A small uint8 network over a size x size RGB image, the shape a NPU is built for: a
/// strided 3x3 convolution and three depthwise-separable blocks, ReLU throughout.
pub fn cnn(size: u32) -> Vec<u8> {
    let s = size as i32;
    let mut g = Graph::new();
    let input = g.tensor(&[1, s, s, 3], UINT8, 1.0 / 255.0, 0, None);
    let act = 0.05f32;
    let wscale = 0.02f32;
    let conv = |g: &mut Graph,
                from: i32,
                cin: i32,
                cout: i32,
                k: i32,
                stride: i32,
                side: i32,
                seed: u32,
                in_scale: f32|
     -> (i32, i32) {
        let weights: Vec<u8> = (0..(cout * k * k * cin) as usize).map(|i| pseudo(i, seed)).collect();
        let w = g.tensor(&[cout, k, k, cin], UINT8, wscale, 128, Some(weights));
        let b = g.tensor(&[cout], INT32, in_scale * wscale, 0, Some(vec![0; 4 * cout as usize]));
        let side = (side + stride - 1) / stride;
        let out = g.tensor(&[1, side, side, cout], UINT8, act, 0, None);
        let options = Table::default()
            .with(0, Field::U8(SAME))
            .with(1, Field::I32(stride))
            .with(2, Field::I32(stride))
            .with(3, Field::U8(RELU))
            .with(4, Field::I32(1))
            .with(5, Field::I32(1));
        g.op(CONV_2D, vec![from, w, b], out, OPTIONS_CONV, options);
        (out, side)
    };
    let depthwise = |g: &mut Graph, from: i32, ch: i32, stride: i32, side: i32, seed: u32| -> (i32, i32) {
        let weights: Vec<u8> = (0..(9 * ch) as usize).map(|i| pseudo(i, seed)).collect();
        let w = g.tensor(&[1, 3, 3, ch], UINT8, wscale, 128, Some(weights));
        let b = g.tensor(&[ch], INT32, act * wscale, 0, Some(vec![0; 4 * ch as usize]));
        let side = (side + stride - 1) / stride;
        let out = g.tensor(&[1, side, side, ch], UINT8, act, 0, None);
        g.op(
            DEPTHWISE_CONV_2D,
            vec![from, w, b],
            out,
            OPTIONS_DEPTHWISE,
            depthwise_options(RELU, stride),
        );
        (out, side)
    };
    let (mut x, mut side) = conv(&mut g, input, 3, 16, 3, 2, s, 1, 1.0 / 255.0);
    let mut ch = 16;
    for (block, (out_ch, stride)) in [(32, 1), (64, 2), (64, 1)].into_iter().enumerate() {
        let (d, sd) = depthwise(&mut g, x, ch, stride, side, 10 + block as u32);
        let (p, sp) = conv(&mut g, d, ch, out_ch, 1, 1, sd, 20 + block as u32, act);
        x = p;
        side = sp;
        ch = out_ch;
    }
    g.finish(input, x)
}

/// Output bytes of `cnn(size)`.
pub fn cnn_output_len(size: u32) -> usize {
    let mut side = size.div_ceil(2);
    side = side.div_ceil(2);
    (side * side * 64) as usize
}
