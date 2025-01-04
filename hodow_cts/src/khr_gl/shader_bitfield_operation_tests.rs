// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cShaderBitfieldOperationTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream has one C++ class per (function, component count); here a case is its input `Data` plus a `Check`, and the shader statement comes from the same component count. The random inputs are drawn once when the tree is built, from a `Random` seeded like upstream's default base seed (0); the draw order within one constructor call is unspecified in C++ and only matters for which numbers a case gets, never for what it checks. The compute program goes through `glu::ShaderProgram` instead of raw shader calls.

use std::ffi::c_void;

use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::float::Float16;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

const ITERATIONS: i32 = 4;

/// The std430 layout of the `Data` buffer block, field for field.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct Data {
    in_uvec4: [u32; 4],
    in_ivec4: [i32; 4],
    in_vec4: [f32; 4],

    in2_uvec4: [u32; 4],
    in2_ivec4: [i32; 4],
    in2_vec4: [f32; 4],

    offset: i32,
    bits: i32,
    padding: [i32; 2],

    out_uvec4: [u32; 4],
    out_ivec4: [i32; 4],
    out_vec4: [f32; 4],

    out2_uvec4: [u32; 4],
    out2_ivec4: [i32; 4],
    out2_vec4: [f32; 4],
}

fn uvec4(x: u32, y: u32, z: u32, w: u32) -> Data {
    Data {
        in_uvec4: [x, y, z, w],
        ..Data::default()
    }
}

fn ivec4(x: i32, y: i32, z: i32, w: i32) -> Data {
    Data {
        in_ivec4: [x, y, z, w],
        ..Data::default()
    }
}

fn vec4(x: f32, y: f32, z: f32, w: f32) -> Data {
    Data {
        in_vec4: [x, y, z, w],
        ..Data::default()
    }
}

#[derive(Clone, Copy)]
enum Check {
    Frexp(usize),
    Ldexp(usize),
    PackUnorm,
    PackSnorm,
    UnpackUnorm,
    UnpackSnorm,
    ExtractUint(usize),
    ExtractInt(usize),
    InsertUint(usize),
    InsertInt(usize),
    /// `narrow` is upstream's `m_func == bitCount/findLSB/findMSB`: those return a lowp int, so only 9 bits are meaningful.
    UnaryUint {
        components: usize,
        func: fn(u32) -> u32,
        narrow: bool,
    },
    UnaryInt {
        components: usize,
        func: fn(i32) -> i32,
    },
    BinaryUint {
        components: usize,
        func: fn(u32, u32) -> (u32, u32),
    },
    BinaryInt {
        components: usize,
        func: fn(i32, i32) -> (i32, i32),
    },
}

struct ShaderBitfieldOperationCase {
    case_name: String,
    glsl_version: GlslVersion,
    data: Data,
    test_statement: String,
    check: Check,
}

fn reduce32_precision_to_16(f: f32) -> f32 {
    Float16::new(f).as_float()
}

fn pack(x: f32, y: f32, z: f32, w: f32, range: f32) -> u32 {
    let channel = |v: f32, shift: u32| (((v * range + 0.5).floor() as i32 & 0xFF) as u32) << shift;
    channel(x, 0) | channel(y, 8) | channel(z, 16) | channel(w, 24)
}

fn check_out_data(result: u32, input: [f32; 4], range: f32) -> bool {
    let expected = pack(input[0], input[1], input[2], input[3], range);
    let expected_mp = pack(
        reduce32_precision_to_16(input[0]),
        reduce32_precision_to_16(input[1]),
        reduce32_precision_to_16(input[2]),
        reduce32_precision_to_16(input[3]),
        range,
    );

    expected == result || expected_mp == result
}

impl ShaderBitfieldOperationCase {
    /// `test`
    fn test(&self, data: &Data) -> bool {
        match self.check {
            Check::Frexp(components) => (0..components).all(|i| {
                if data.in_vec4[i] == 0.0 {
                    if data.out_vec4[i] != 0.0 || data.out_ivec4[i] != 0 {
                        return false;
                    }
                } else if data.out_vec4[i].abs() < 0.5 || data.out_vec4[i].abs() >= 1.0 {
                    return false;
                }

                let result = data.out_vec4[i] * 2.0f32.powf(data.out_ivec4[i] as f32);
                (result - data.in_vec4[i]).abs() <= 0.0001
            }),
            Check::Ldexp(components) => (0..components).all(|i| {
                let expected = data.in_vec4[i] * 2.0f32.powi(data.in_ivec4[i]);
                (expected - data.out_vec4[i]).abs() <= 0.0001
            }),
            Check::PackUnorm => check_out_data(data.out_uvec4[0], data.in_vec4, 255.0),
            Check::PackSnorm => check_out_data(data.out_uvec4[0], data.in_vec4, 127.0),
            Check::UnpackUnorm => (0..4).all(|i| {
                let x = ((data.in_uvec4[0] >> (8 * i)) & 0xFF) as f32 / 255.0;
                (data.out_vec4[i] - x).abs() <= 0.0001
            }),
            Check::UnpackSnorm => (0..4).all(|i| {
                let x = ((data.in_uvec4[0] >> (8 * i)) & 0xFF) as u8 as i8;
                let x = (f32::from(x) / 127.0).clamp(-1.0, 1.0);
                (data.out_vec4[i] - x).abs() <= 0.0001
            }),
            Check::ExtractUint(components) => (0..components).all(|i| {
                let mask = if data.bits == 32 {
                    0xFFFF_FFFF
                } else {
                    (1u32 << data.bits) - 1
                };
                let expected = (data.in_uvec4[i] >> data.offset) & mask;
                data.out_uvec4[i] == expected
            }),
            Check::ExtractInt(components) => (0..components).all(|i| {
                let mut expected = data.in_ivec4[i] << (32 - (data.offset + data.bits));
                expected >>= 32 - data.bits;
                data.out_ivec4[i] == expected
            }),
            Check::InsertUint(components) => (0..components).all(|i| {
                let mask = if data.bits == 32 {
                    !0u32
                } else {
                    (1u32 << data.bits) - 1
                };
                let expected =
                    (data.in_uvec4[i] & !(mask << data.offset)) | ((data.in2_uvec4[i] & mask) << data.offset);
                data.out_uvec4[i] == expected
            }),
            Check::InsertInt(components) => (0..components).all(|i| {
                let mask = if data.bits == 32 {
                    !0u32
                } else {
                    (1u32 << data.bits) - 1
                };
                let expected = (data.in_ivec4[i] as u32 & !(mask << data.offset))
                    | ((data.in2_ivec4[i] as u32 & mask) << data.offset);
                data.out_ivec4[i] == expected as i32
            }),
            Check::UnaryUint {
                components,
                func,
                narrow,
            } => (0..components).all(|i| {
                let expected = func(data.in_uvec4[i]);
                let mut output = data.out_uvec4[i];
                if narrow {
                    // The built-in bitCount, findLSB and findMSB functions return a lowp int, which can be encoded with as little as 9 bits. Since findLSB and findMSB can return negative values (namely, -1), the output cannot be compared directly against a (32-bit) GLuint.
                    let output_9bits = output & 0x1ff;
                    let sign_extend = if output_9bits & 0x100 != 0 { 0xffff_fe00 } else { 0 };
                    output = output_9bits | sign_extend;
                }
                output == expected
            }),
            Check::UnaryInt { components, func } => {
                (0..components).all(|i| data.out_ivec4[i] == func(data.in_ivec4[i]))
            }
            Check::BinaryUint { components, func } => (0..components).all(|i| {
                let (expected, expected2) = func(data.in_uvec4[i], data.in2_uvec4[i]);
                data.out_uvec4[i] == expected && data.out2_uvec4[i] == expected2
            }),
            Check::BinaryInt { components, func } => (0..components).all(|i| {
                let (expected, expected2) = func(data.in_ivec4[i], data.in2_ivec4[i]);
                data.out_ivec4[i] == expected && data.out2_ivec4[i] == expected2
            }),
        }
    }
}

const COMPUTE_SHADER_SOURCE: &str = "${VERSION_DECL}\n\
    \n\
    layout(local_size_x = 1) in;\n\
    \n\
    layout(binding = 0, std430) buffer Data {\n\
    \x20   uvec4 inUvec4;\n\
    \x20   ivec4 inIvec4;\n\
    \x20   vec4 inVec4;\n\
    \n\
    \x20   uvec4 in2Uvec4;\n\
    \x20   ivec4 in2Ivec4;\n\
    \x20   vec4 in2Vec4;\n\
    \n\
    \x20   int offset;\n\
    \x20   int bits;\n\
    \n\
    \x20   uvec4 outUvec4;\n\
    \x20   ivec4 outIvec4;\n\
    \x20   vec4 outVec4;\n\
    \n\
    \x20   uvec4 out2Uvec4;\n\
    \x20   ivec4 out2Ivec4;\n\
    \x20   vec4 out2Vec4;\n\
    };\n\
    \n\
    void main()\n\
    {\n\
    \x20   ${TEST_STATEMENT};\n\
    }\n";

impl TestCase for ShaderBitfieldOperationCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let source = COMPUTE_SHADER_SOURCE
            .replace("${VERSION_DECL}", self.glsl_version.declaration())
            .replace("${TEST_STATEMENT}", &self.test_statement);

        let mut buffer = 0;
        // SAFETY: `buffer` receives one name; the upload reads `size_of::<Data>()` bytes from a live `Data`.
        unsafe {
            gl.gen_buffers(1, &mut buffer);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                size_of::<Data>() as isize,
                std::ptr::from_ref(&self.data).cast::<c_void>(),
                glw::GL_STATIC_DRAW,
            );
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer);
        }

        let program = ShaderProgram::new(gl, &ProgramSources::default().with(ShaderType::Compute, source));
        if !program.is_ok() {
            // SAFETY: the buffer created above, deleted once.
            unsafe { gl.delete_buffers(1, &buffer) };
            return Err(TestError::Fail(format!(
                "Compile or link failed: {}",
                program.build_failure_summary().unwrap_or_default()
            )));
        }

        // SAFETY: a linked compute program; the mapped range covers exactly the `Data` just uploaded and is read once before the unmap.
        let results = unsafe {
            gl.use_program(program.program());
            gl.dispatch_compute(1, 1, 1);

            let mapped = gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                size_of::<Data>() as isize,
                glw::GL_MAP_READ_BIT,
            );
            let results = if mapped.is_null() {
                None
            } else {
                Some(std::ptr::read_unaligned(mapped.cast::<Data>()))
            };
            gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);

            gl.use_program(0);
            gl.delete_buffers(1, &buffer);
            results
        };

        let results = results.ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
        Ok(if self.test(&results) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// The swizzle of the first `components` lanes: `.x`, `.xy`, `.xyz` or nothing for all four.
fn lanes(name: &str, components: usize) -> String {
    match components {
        1 => format!("{name}.x"),
        2 => format!("{name}.xy"),
        3 => format!("{name}.xyz"),
        _ => name.to_string(),
    }
}

fn exact_aligned(offset: i32, bits: i32) -> i32 {
    if offset + bits > 32 {
        offset - ((offset + bits) - 32)
    } else {
        offset
    }
}

struct Builder {
    glsl_version: GlslVersion,
    rnd: Random,
}

impl Builder {
    fn case(&self, name: impl Into<String>, data: Data, test_statement: String, check: Check) -> Box<dyn TestCase> {
        Box::new(ShaderBitfieldOperationCase {
            case_name: name.into(),
            glsl_version: self.glsl_version,
            data,
            test_statement,
            check,
        })
    }

    #[allow(dead_code)]
    fn float(&mut self) -> f32 {
        self.rnd.get_float()
    }

    fn uint(&mut self) -> u32 {
        self.rnd.get_uint32()
    }

    /// Four random lanes, of which only the first `components` matter; the rest stay zero like upstream's `Uvec4(x, y, z, w)` defaults.
    fn random_uvec4(&mut self, components: usize) -> Data {
        let mut v = [0u32; 4];
        for lane in v.iter_mut().take(components) {
            *lane = self.uint();
        }
        uvec4(v[0], v[1], v[2], v[3])
    }

    fn random_ivec4(&mut self, components: usize) -> Data {
        let mut v = [0i32; 4];
        for lane in v.iter_mut().take(components) {
            *lane = self.uint() as i32;
        }
        ivec4(v[0], v[1], v[2], v[3])
    }

    /// `Vec4(rnd.getFloat(), -rnd.getFloat(), rnd.getFloat(), -rnd.getFloat())`: odd lanes are negated, `all_positive` keeps them as drawn.
    fn random_vec4(&mut self, components: usize, all_positive: bool) -> Data {
        let mut v = [0.0f32; 4];
        for (i, lane) in v.iter_mut().enumerate().take(components) {
            let f = self.rnd.get_float();
            *lane = if i % 2 == 1 && !all_positive { -f } else { f };
        }
        vec4(v[0], v[1], v[2], v[3])
    }

    fn random_exponents(&mut self, components: usize) -> Data {
        let mut v = [0i32; 4];
        for lane in v.iter_mut().take(components) {
            *lane = self.rnd.get_int(-8, 8);
        }
        ivec4(v[0], v[1], v[2], v[3])
    }

    fn offset_and_bits(&mut self) -> (i32, i32) {
        let offset = self.rnd.get_int(0, 31);
        let bits = self.rnd.get_int(1, 32);
        (exact_aligned(offset, bits), bits)
    }
}

const FLOAT_TYPES: [&str; 4] = ["float", "vec2", "vec3", "vec4"];
const UINT_TYPES: [&str; 4] = ["uint", "uvec2", "uvec3", "uvec4"];
const INT_TYPES: [&str; 4] = ["int", "ivec2", "ivec3", "ivec4"];

fn bitfield_reverse(input: u32) -> u32 {
    input.reverse_bits()
}

fn bit_count(input: u32) -> u32 {
    input.count_ones()
}

fn find_lsb(input: u32) -> u32 {
    if input == 0 { u32::MAX } else { input.trailing_zeros() }
}

fn find_msb_u(input: u32) -> u32 {
    if input == 0 {
        u32::MAX
    } else {
        31 - input.leading_zeros()
    }
}

fn find_msb_i(input: i32) -> i32 {
    if input == 0 || input == -1 {
        -1
    } else if input > 0 {
        (31 - input.leading_zeros()) as i32
    } else {
        (31 - (!input).leading_zeros()) as i32
    }
}

fn bitfield_reverse_i(input: i32) -> i32 {
    bitfield_reverse(input as u32) as i32
}

fn bit_count_i(input: i32) -> i32 {
    bit_count(input as u32) as i32
}

fn find_lsb_i(input: i32) -> i32 {
    find_lsb(input as u32) as i32
}

fn uadd_carry(input: u32, input2: u32) -> (u32, u32) {
    let result = input.wrapping_add(input2);
    (result, u32::from(input > result))
}

fn usub_borrow(input: u32, input2: u32) -> (u32, u32) {
    (input.wrapping_sub(input2), u32::from(input2 > input))
}

fn umul_extended(input: u32, input2: u32) -> (u32, u32) {
    let result = u64::from(input) * u64::from(input2);
    ((result >> 32) as u32, (result & 0xFFFF_FFFF) as u32)
}

fn imul_extended(input: i32, input2: i32) -> (i32, i32) {
    let result = i64::from(input) * i64::from(input2);
    ((result >> 32) as i32, (result & 0xFFFF_FFFF) as i32)
}

fn add_float_group(b: &mut Builder, group: &mut TestCaseGroup, name: &str, is_ldexp: bool) {
    let mut sub = TestCaseGroup::new(name);
    for (n, type_name) in FLOAT_TYPES.iter().enumerate() {
        let components = n + 1;
        let (statement, check) = if is_ldexp {
            (
                format!(
                    "{} = ldexp({}, {})",
                    lanes("outVec4", components),
                    lanes("inVec4", components),
                    lanes("inIvec4", components)
                ),
                Check::Ldexp(components),
            )
        } else {
            (
                format!(
                    "{} = frexp({}, {})",
                    lanes("outVec4", components),
                    lanes("inVec4", components),
                    lanes("outIvec4", components)
                ),
                Check::Frexp(components),
            )
        };

        sub.add_child(b.case(format!("{type_name}_zero"), Data::default(), statement.clone(), check));
        for i in 0..ITERATIONS {
            let mut data = b.random_vec4(components, false);
            if is_ldexp {
                data.in_ivec4 = b.random_exponents(components).in_ivec4;
            }
            sub.add_child(b.case(format!("{type_name}_{i}"), data, statement.clone(), check));
        }
    }
    group.add_child(sub);
}

fn add_pack_group(b: &mut Builder, group: &mut TestCaseGroup, name: &str, statement: &str, check: Check) {
    let mut sub = TestCaseGroup::new(name);
    for i in 0..ITERATIONS {
        let data = match check {
            Check::PackUnorm => b.random_vec4(4, true),
            Check::PackSnorm => b.random_vec4(4, false),
            _ => {
                let word = b.uint();
                uvec4(word, 0, 0, 0)
            }
        };
        sub.add_child(b.case(i.to_string(), data, statement.to_string(), check));
    }
    group.add_child(sub);
}

fn add_extract_insert_group(b: &mut Builder, group: &mut TestCaseGroup, name: &str, is_insert: bool) {
    let mut sub = TestCaseGroup::new(name);
    for is_signed in [false, true] {
        let types = if is_signed { &INT_TYPES } else { &UINT_TYPES };
        for (n, type_name) in types.iter().enumerate() {
            let components = n + 1;
            let vec_name = if is_signed { "Ivec4" } else { "Uvec4" };
            let (out, input, input2) = (
                lanes(&format!("out{vec_name}"), components),
                lanes(&format!("in{vec_name}"), components),
                lanes(&format!("in2{vec_name}"), components),
            );
            let statement = if is_insert {
                format!("{out} = bitfieldInsert({input}, {input2}, offset, bits)")
            } else {
                format!("{out} = bitfieldExtract({input}, offset, bits)")
            };
            let check = match (is_insert, is_signed) {
                (false, false) => Check::ExtractUint(components),
                (false, true) => Check::ExtractInt(components),
                (true, false) => Check::InsertUint(components),
                (true, true) => Check::InsertInt(components),
            };

            for i in 0..ITERATIONS {
                let mut data = if is_signed {
                    b.random_ivec4(components)
                } else {
                    b.random_uvec4(components)
                };
                if is_insert {
                    let insert = if is_signed {
                        b.random_ivec4(components)
                    } else {
                        b.random_uvec4(components)
                    };
                    data.in2_uvec4 = insert.in_uvec4;
                    data.in2_ivec4 = insert.in_ivec4;
                }
                let (offset, bits) = b.offset_and_bits();
                data.offset = offset;
                data.bits = bits;
                sub.add_child(b.case(format!("{type_name}_{i}"), data, statement.clone(), check));
            }
        }
    }
    group.add_child(sub);
}

fn add_unary_group(
    b: &mut Builder,
    group: &mut TestCaseGroup,
    name: &str,
    func_u: fn(u32) -> u32,
    func_i: fn(i32) -> i32,
    narrow: bool,
) {
    let mut sub = TestCaseGroup::new(name);

    let uint_statement = |components: usize| {
        let vec_type = ["uint", "uvec2", "uvec3", "uvec4"][components - 1];
        format!(
            "{} = {vec_type}({name}({}))",
            lanes("outUvec4", components),
            lanes("inUvec4", components)
        )
    };
    let int_statement = |components: usize| {
        format!(
            "{} = {name}({})",
            lanes("outIvec4", components),
            lanes("inIvec4", components)
        )
    };

    let uint_check = |components: usize| Check::UnaryUint {
        components,
        func: func_u,
        narrow,
    };
    let int_check = |components: usize| Check::UnaryInt {
        components,
        func: func_i,
    };

    sub.add_child(b.case("uint_zero", Data::default(), uint_statement(1), uint_check(1)));
    for (n, type_name) in UINT_TYPES.iter().enumerate() {
        let components = n + 1;
        for i in 0..ITERATIONS {
            let data = b.random_uvec4(components);
            sub.add_child(b.case(
                format!("{type_name}_{i}"),
                data,
                uint_statement(components),
                uint_check(components),
            ));
        }
    }

    sub.add_child(b.case("int_zero", Data::default(), int_statement(1), int_check(1)));
    sub.add_child(b.case("int_minus_one", ivec4(-1, 0, 0, 0), int_statement(1), int_check(1)));
    for (n, type_name) in INT_TYPES.iter().enumerate() {
        let components = n + 1;
        for i in 0..ITERATIONS {
            let data = b.random_ivec4(components);
            sub.add_child(b.case(
                format!("{type_name}_{i}"),
                data,
                int_statement(components),
                int_check(components),
            ));
        }
    }

    group.add_child(sub);
}

fn add_binary_group(
    b: &mut Builder,
    group: &mut TestCaseGroup,
    name: &str,
    signed_func: Option<fn(i32, i32) -> (i32, i32)>,
    unsigned_func: Option<fn(u32, u32) -> (u32, u32)>,
) {
    let mut sub = TestCaseGroup::new(name);
    let is_signed = signed_func.is_some();
    let types = if is_signed { &INT_TYPES } else { &UINT_TYPES };
    let vec_name = if is_signed { "Ivec4" } else { "Uvec4" };
    let extended = name.ends_with("Extended");

    for (n, type_name) in types.iter().enumerate() {
        let components = n + 1;
        let (out, out2) = (
            lanes(&format!("out{vec_name}"), components),
            lanes(&format!("out2{vec_name}"), components),
        );
        let (input, input2) = (
            lanes(&format!("in{vec_name}"), components),
            lanes(&format!("in2{vec_name}"), components),
        );
        let statement = if extended {
            format!("{name}({input}, {input2}, {out}, {out2});")
        } else {
            format!("{out} = {name}({input}, {input2}, {out2});")
        };

        for i in 0..ITERATIONS {
            let (mut data, other) = if is_signed {
                (b.random_ivec4(components), b.random_ivec4(components))
            } else {
                (b.random_uvec4(components), b.random_uvec4(components))
            };
            data.in2_uvec4 = other.in_uvec4;
            data.in2_ivec4 = other.in_ivec4;
            let check = match (signed_func, unsigned_func) {
                (Some(func), _) => Check::BinaryInt { components, func },
                (None, Some(func)) => Check::BinaryUint { components, func },
                (None, None) => unreachable!("every binary group has a function"),
            };
            sub.add_child(b.case(format!("{type_name}_{i}"), data, statement.clone(), check));
        }
    }

    group.add_child(sub);
}

/// `ShaderBitfieldOperationTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut b = Builder {
        glsl_version,
        rnd: Random::new(0),
    };
    let mut group = TestCaseGroup::new("shader_bitfield_operation");

    add_float_group(&mut b, &mut group, "frexp", false);
    add_float_group(&mut b, &mut group, "ldexp", true);
    add_pack_group(
        &mut b,
        &mut group,
        "packUnorm4x8",
        "outUvec4.x = packUnorm4x8(inVec4)",
        Check::PackUnorm,
    );
    add_pack_group(
        &mut b,
        &mut group,
        "packSnorm4x8",
        "outUvec4.x = packSnorm4x8(inVec4)",
        Check::PackSnorm,
    );
    add_pack_group(
        &mut b,
        &mut group,
        "unpackUnorm4x8",
        "outVec4 = unpackUnorm4x8(inUvec4.x)",
        Check::UnpackUnorm,
    );
    add_pack_group(
        &mut b,
        &mut group,
        "unpackSnorm4x8",
        "outVec4 = unpackSnorm4x8(inUvec4.x)",
        Check::UnpackSnorm,
    );
    add_extract_insert_group(&mut b, &mut group, "bitfieldExtract", false);
    add_extract_insert_group(&mut b, &mut group, "bitfieldInsert", true);

    add_unary_group(
        &mut b,
        &mut group,
        "bitfieldReverse",
        bitfield_reverse,
        bitfield_reverse_i,
        false,
    );
    add_unary_group(&mut b, &mut group, "bitCount", bit_count, bit_count_i, true);
    add_unary_group(&mut b, &mut group, "findLSB", find_lsb, find_lsb_i, true);
    add_unary_group(&mut b, &mut group, "findMSB", find_msb_u, find_msb_i, true);

    add_binary_group(&mut b, &mut group, "uaddCarry", None, Some(uadd_carry));
    add_binary_group(&mut b, &mut group, "usubBorrow", None, Some(usub_borrow));
    add_binary_group(&mut b, &mut group, "umulExtended", None, Some(umul_extended));
    add_binary_group(&mut b, &mut group, "imulExtended", Some(imul_extended), None);

    group
}
