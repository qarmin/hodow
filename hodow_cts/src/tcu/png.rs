// SPDX-License-Identifier: Apache-2.0
//
// Replaces the `tcu::ImageIO::loadPNG` / `tcu::TexturePNG` path of VK-GL-CTS (framework/common
// tcuImageIO.cpp), which wraps libpng.
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Modifications: rewritten in Rust for hodow_cts, dependency-free (the binary must keep linking
// only libc/libgcc). Handles what the CTS data archive uses: non-interlaced, 8 bits per channel,
// greyscale / grey+alpha / RGB / RGBA. Anything else is refused rather than approximated.

use crate::tcu::surface::Surface;

fn bad(msg: &str) -> String {
    format!("PNG: {msg}")
}

struct BitReader<'a> {
    data: &'a [u8],
    pos: usize,
    bit: u32,
}

impl<'a> BitReader<'a> {
    fn new(data: &'a [u8]) -> Self {
        Self { data, pos: 0, bit: 0 }
    }

    fn bits(&mut self, n: u32) -> Result<u32, String> {
        let mut v = 0u32;
        for i in 0..n {
            let byte = *self.data.get(self.pos).ok_or_else(|| bad("truncated deflate stream"))?;
            v |= (((byte >> self.bit) & 1) as u32) << i;
            self.bit += 1;
            if self.bit == 8 {
                self.bit = 0;
                self.pos += 1;
            }
        }
        Ok(v)
    }

    fn align(&mut self) {
        if self.bit != 0 {
            self.bit = 0;
            self.pos += 1;
        }
    }
}

struct Huffman {
    counts: [u16; 16],
    symbols: Vec<u16>,
}

impl Huffman {
    fn new(lengths: &[u8]) -> Self {
        let mut counts = [0u16; 16];
        for &l in lengths {
            counts[l as usize] += 1;
        }
        counts[0] = 0;
        let mut offsets = [0u16; 16];
        for i in 1..16 {
            offsets[i] = offsets[i - 1] + counts[i - 1];
        }
        let mut symbols = vec![0u16; lengths.len()];
        for (sym, &l) in lengths.iter().enumerate() {
            if l != 0 {
                symbols[offsets[l as usize] as usize] = sym as u16;
                offsets[l as usize] += 1;
            }
        }
        Self { counts, symbols }
    }

    fn decode(&self, br: &mut BitReader) -> Result<u16, String> {
        let mut code = 0i32;
        let mut first = 0i32;
        let mut index = 0i32;
        for len in 1..16 {
            code |= br.bits(1)? as i32;
            let count = self.counts[len] as i32;
            if code - count < first {
                return Ok(self.symbols[(index + (code - first)) as usize]);
            }
            index += count;
            first += count;
            first <<= 1;
            code <<= 1;
        }
        Err(bad("invalid huffman code"))
    }
}

const LEN_BASE: [u16; 29] = [
    3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258,
];
const LEN_EXTRA: [u8; 29] = [
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0,
];
const DIST_BASE: [u16; 30] = [
    1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
    8193, 12289, 16385, 24577,
];
const DIST_EXTRA: [u8; 30] = [
    0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13,
];

fn inflate_block(br: &mut BitReader, out: &mut Vec<u8>, lit: &Huffman, dist: &Huffman) -> Result<(), String> {
    loop {
        let sym = lit.decode(br)? as usize;
        if sym < 256 {
            out.push(sym as u8);
        } else if sym == 256 {
            return Ok(());
        } else {
            let sym = sym - 257;
            if sym >= 29 {
                return Err(bad("invalid length symbol"));
            }
            let len = LEN_BASE[sym] as usize + br.bits(LEN_EXTRA[sym] as u32)? as usize;
            let dsym = dist.decode(br)? as usize;
            if dsym >= 30 {
                return Err(bad("invalid distance symbol"));
            }
            let d = DIST_BASE[dsym] as usize + br.bits(DIST_EXTRA[dsym] as u32)? as usize;
            if d > out.len() {
                return Err(bad("distance too far back"));
            }
            for _ in 0..len {
                let b = out[out.len() - d];
                out.push(b);
            }
        }
    }
}

/// Inflates a zlib stream (2 byte header, deflate data, adler32 ignored).
fn zlib_inflate(data: &[u8]) -> Result<Vec<u8>, String> {
    if data.len() < 2 {
        return Err(bad("zlib stream too short"));
    }
    let mut br = BitReader::new(&data[2..]);
    let mut out = Vec::new();
    loop {
        let last = br.bits(1)?;
        let kind = br.bits(2)?;
        match kind {
            0 => {
                br.align();
                let p = br.pos;
                if p + 4 > br.data.len() {
                    return Err(bad("truncated stored block"));
                }
                let len = br.data[p] as usize | (br.data[p + 1] as usize) << 8;
                let start = p + 4;
                if start + len > br.data.len() {
                    return Err(bad("truncated stored block"));
                }
                out.extend_from_slice(&br.data[start..start + len]);
                br.pos = start + len;
            }
            1 => {
                let mut l = [0u8; 288];
                for (i, v) in l.iter_mut().enumerate() {
                    *v = match i {
                        0..=143 => 8,
                        144..=255 => 9,
                        256..=279 => 7,
                        _ => 8,
                    };
                }
                let lit = Huffman::new(&l);
                let dist = Huffman::new(&[5u8; 30]);
                inflate_block(&mut br, &mut out, &lit, &dist)?;
            }
            2 => {
                let hlit = br.bits(5)? as usize + 257;
                let hdist = br.bits(5)? as usize + 1;
                let hclen = br.bits(4)? as usize + 4;
                const ORDER: [usize; 19] = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
                let mut cl = [0u8; 19];
                for &o in ORDER.iter().take(hclen) {
                    cl[o] = br.bits(3)? as u8;
                }
                let clh = Huffman::new(&cl);
                let mut lengths = vec![0u8; hlit + hdist];
                let mut i = 0;
                while i < hlit + hdist {
                    let sym = clh.decode(&mut br)?;
                    match sym {
                        0..=15 => {
                            lengths[i] = sym as u8;
                            i += 1;
                        }
                        16 => {
                            if i == 0 {
                                return Err(bad("repeat with no previous length"));
                            }
                            let prev = lengths[i - 1];
                            let n = 3 + br.bits(2)? as usize;
                            if i + n > lengths.len() {
                                return Err(bad("code length overflow"));
                            }
                            lengths[i..i + n].fill(prev);
                            i += n;
                        }
                        17 | 18 => {
                            let n = (if sym == 17 { 3 + br.bits(3)? } else { 11 + br.bits(7)? }) as usize;
                            if i + n > lengths.len() {
                                return Err(bad("code length overflow"));
                            }
                            i += n;
                        }
                        _ => return Err(bad("invalid code length symbol")),
                    }
                }
                let lit = Huffman::new(&lengths[..hlit]);
                let dist = Huffman::new(&lengths[hlit..]);
                inflate_block(&mut br, &mut out, &lit, &dist)?;
            }
            _ => return Err(bad("invalid deflate block type")),
        }
        if last == 1 {
            return Ok(out);
        }
    }
}

fn paeth(a: u8, b: u8, c: u8) -> u8 {
    let p = a as i32 + b as i32 - c as i32;
    let pa = (p - a as i32).abs();
    let pb = (p - b as i32).abs();
    let pc = (p - c as i32).abs();
    if pa <= pb && pa <= pc {
        a
    } else if pb <= pc {
        b
    } else {
        c
    }
}

/// Decodes a PNG file into an RGBA8 `tcu::Surface` (row 0 = top row of the file, as upstream's
/// `TexturePNG::getLevel` + `copy` yield).
pub fn load_png(file: &[u8]) -> Result<Surface, String> {
    const SIG: [u8; 8] = [0x89, b'P', b'N', b'G', 0x0d, 0x0a, 0x1a, 0x0a];
    if file.len() < 8 || file[..8] != SIG {
        return Err(bad("bad signature"));
    }
    let mut pos = 8;
    let mut width = 0usize;
    let mut height = 0usize;
    let mut color_type = 0u8;
    let mut idat = Vec::new();
    while pos + 8 <= file.len() {
        let len = u32::from_be_bytes([file[pos], file[pos + 1], file[pos + 2], file[pos + 3]]) as usize;
        let kind = &file[pos + 4..pos + 8];
        let body_start = pos + 8;
        if body_start + len > file.len() {
            return Err(bad("truncated chunk"));
        }
        let body = &file[body_start..body_start + len];
        match kind {
            b"IHDR" => {
                if len < 13 {
                    return Err(bad("short IHDR"));
                }
                width = u32::from_be_bytes([body[0], body[1], body[2], body[3]]) as usize;
                height = u32::from_be_bytes([body[4], body[5], body[6], body[7]]) as usize;
                color_type = body[9];
                if body[8] != 8 || body[12] != 0 {
                    return Err(bad("only non-interlaced 8 bit images are supported"));
                }
            }
            b"IDAT" => idat.extend_from_slice(body),
            b"IEND" => break,
            _ => {}
        }
        pos = body_start + len + 4;
    }

    let channels = match color_type {
        0 => 1,
        2 => 3,
        4 => 2,
        6 => 4,
        _ => return Err(bad("unsupported colour type")),
    };
    let raw = zlib_inflate(&idat)?;
    let stride = width * channels;
    if raw.len() < (stride + 1) * height {
        return Err(bad("image data too short"));
    }

    let mut img = vec![0u8; stride * height];
    for y in 0..height {
        let filter = raw[y * (stride + 1)];
        let line = &raw[y * (stride + 1) + 1..(y + 1) * (stride + 1)];
        for x in 0..stride {
            let a = if x >= channels {
                img[y * stride + x - channels]
            } else {
                0
            };
            let b = if y > 0 { img[(y - 1) * stride + x] } else { 0 };
            let c = if x >= channels && y > 0 {
                img[(y - 1) * stride + x - channels]
            } else {
                0
            };
            let pred = match filter {
                0 => 0,
                1 => a,
                2 => b,
                3 => ((a as u16 + b as u16) / 2) as u8,
                4 => paeth(a, b, c),
                _ => return Err(bad("invalid filter type")),
            };
            img[y * stride + x] = line[x].wrapping_add(pred);
        }
    }

    let mut surface = Surface::new(width as i32, height as i32);
    for y in 0..height {
        for x in 0..width {
            let p = &img[y * stride + x * channels..y * stride + (x + 1) * channels];
            let (r, g, b, a) = match color_type {
                0 => (p[0], p[0], p[0], 255),
                2 => (p[0], p[1], p[2], 255),
                4 => (p[0], p[0], p[0], p[1]),
                _ => (p[0], p[1], p[2], p[3]),
            };
            surface.set_pixel(
                x as i32,
                y as i32,
                crate::tcu::rgba::RGBA::new(r as i32, g as i32, b as i32, a as i32),
            );
        }
    }
    Ok(surface)
}
