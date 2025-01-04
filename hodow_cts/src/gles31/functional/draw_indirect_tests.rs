// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// The `draw_arrays_indirect`, `draw_elements_indirect` and `random` groups of
// `DrawTests::init` - every case goes through `gls::DrawTest` via
// `draw_test_case::DrawTestCase`. `instancing` (a `sglr::ShaderProgram` grid) and
// `compute_interop` (draw commands written by a compute shader) are not ported here.
// `draw_tests.rs` registers these next to its own `negative` group.

use std::collections::HashSet;

use crate::gles31::functional::draw_test_case::DrawTestCase;
use crate::gls::draw_test::spec::{
    AttributeSpec, CompatibilityTestType, DrawMethod, DrawTestSpec, IndexType, InputType, OutputType, Primitive,
    Storage, Usage,
};
use crate::glu::{ApiType, TestCase, TestCaseGroup};
use crate::tcu::Random;

/// `TestIterationType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestIterationType {
    DrawCount,
    InstanceCount,
}

/// `addTestIterations`
fn add_test_iterations(test: &mut DrawTestCase, spec: &mut DrawTestSpec, iteration_type: TestIterationType) {
    match iteration_type {
        TestIterationType::DrawCount => {
            for count in [1, 5, 25] {
                spec.primitive_count = count;
                test.add_iteration(spec.clone(), &format!("draw count = {count}"));
            }
        }
        TestIterationType::InstanceCount => {
            for count in [1, 4, 11] {
                spec.instance_count = count;
                test.add_iteration(spec.clone(), &format!("instance count = {count}"));
            }
        }
    }
}

fn float_vec2_attribute(component_count: i32) -> AttributeSpec {
    AttributeSpec {
        input_type: InputType::Float,
        output_type: OutputType::Vec2,
        storage: Storage::Buffer,
        usage: Usage::StaticDraw,
        component_count,
        offset: 0,
        stride: 0,
        normalize: false,
        instance_divisor: 0,
        use_default_attribute: false,
        ..Default::default()
    }
}

fn base_spec(method: DrawMethod, primitive: Primitive, index_type: IndexType, index_storage: Storage) -> DrawTestSpec {
    let mut spec = DrawTestSpec::new(ApiType::es(3, 1));
    spec.primitive = primitive;
    spec.primitive_count = 5;
    spec.draw_method = method;
    spec.index_type = index_type;
    spec.index_pointer_offset = 0;
    spec.index_storage = index_storage;
    spec.first = 0;
    spec.index_min = 0;
    spec.index_max = 0;
    spec.instance_count = 1;
    spec.indirect_offset = 0;
    spec
}

/// `genBasicSpec`
fn gen_basic_spec(method: DrawMethod) -> DrawTestSpec {
    let mut spec = base_spec(method, Primitive::Triangles, IndexType::Last, Storage::Last);

    spec.attribs.push(float_vec2_attribute(4));
    spec.attribs.push(float_vec2_attribute(2));
    spec
}

/// `AttributeGroup`
fn attribute_group(
    name: &str,
    method: DrawMethod,
    primitive: Primitive,
    index_type: IndexType,
    index_storage: Storage,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    // Single attribute
    {
        let mut test = DrawTestCase::new("single_attribute");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(2));

        add_test_iterations(&mut test, &mut spec, TestIterationType::DrawCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute
    {
        let mut test = DrawTestCase::new("multiple_attributes");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(4));
        spec.attribs.push(float_vec2_attribute(2));

        add_test_iterations(&mut test, &mut spec, TestIterationType::DrawCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute, second one divided
    {
        let mut test = DrawTestCase::new("instanced_attributes");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(4));

        // Add another position component so the instances wont be drawn on each other
        spec.attribs.push(AttributeSpec {
            instance_divisor: 1,
            additional_position_attribute: true,
            ..float_vec2_attribute(2)
        });

        // Instanced color
        spec.attribs.push(AttributeSpec {
            instance_divisor: 1,
            ..float_vec2_attribute(3)
        });

        add_test_iterations(&mut test, &mut spec, TestIterationType::InstanceCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute, second one default
    {
        let mut test = DrawTestCase::new("default_attribute");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(2));
        spec.attribs.push(float_vec2_attribute(2));

        struct IoPair {
            input: InputType,
            output: OutputType,
            component_count: i32,
        }

        let io_pairs = [
            IoPair {
                input: InputType::Float,
                output: OutputType::Vec2,
                component_count: 4,
            },
            IoPair {
                input: InputType::Float,
                output: OutputType::Vec4,
                component_count: 2,
            },
            IoPair {
                input: InputType::Int,
                output: OutputType::IVec3,
                component_count: 4,
            },
            IoPair {
                input: InputType::UnsignedInt,
                output: OutputType::UVec2,
                component_count: 4,
            },
        ];

        for io_pair in &io_pairs {
            let desc = format!(
                "{}{} to {}",
                io_pair.input.to_str(),
                io_pair.component_count,
                io_pair.output.to_str()
            );

            spec.attribs[1] = AttributeSpec {
                input_type: io_pair.input,
                output_type: io_pair.output,
                storage: Storage::Buffer,
                usage: Usage::StaticDraw,
                component_count: io_pair.component_count,
                offset: 0,
                stride: 0,
                normalize: false,
                instance_divisor: 0,
                use_default_attribute: true,
                ..Default::default()
            };

            test.add_iteration(spec.clone(), &desc);
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `IndexGroup`
fn index_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    struct IndexTest {
        index_type: IndexType,
        offsets: &'static [i32],
    }

    let tests = [
        IndexTest {
            index_type: IndexType::Byte,
            offsets: &[0, 1],
        },
        IndexTest {
            index_type: IndexType::Short,
            offsets: &[0, 2],
        },
        IndexTest {
            index_type: IndexType::Int,
            offsets: &[0, 4],
        },
    ];

    let mut group = TestCaseGroup::new(name);
    let mut spec = gen_basic_spec(method);

    spec.index_storage = Storage::Buffer;

    for index_test in &tests {
        let mut test = DrawTestCase::new(format!("index_{}", index_test.index_type.to_str()));

        spec.index_type = index_test.index_type;

        for &offset in index_test.offsets {
            let iteration_desc = format!("first vertex {}", offset / index_test.index_type.size());
            spec.index_pointer_offset = offset;
            test.add_iteration(spec.clone(), &iteration_desc);
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `BaseVertexGroup`
fn base_vertex_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    struct IndexTest {
        positive_base: bool,
        index_type: IndexType,
        base_vertex: [i32; 2],
    }

    let tests = [
        IndexTest {
            positive_base: true,
            index_type: IndexType::Byte,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: true,
            index_type: IndexType::Short,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: true,
            index_type: IndexType::Int,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Byte,
            base_vertex: [-1, -2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Short,
            base_vertex: [-1, -2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Int,
            base_vertex: [-1, -2],
        },
    ];

    let mut group = TestCaseGroup::new(name);
    let mut spec = gen_basic_spec(method);

    spec.index_storage = Storage::Buffer;

    for index_test in &tests {
        let mut test = DrawTestCase::new(format!(
            "index_{}{}",
            if index_test.positive_base { "" } else { "neg_" },
            index_test.index_type.to_str()
        ));

        spec.index_type = index_test.index_type;

        for base_vertex in index_test.base_vertex {
            spec.base_vertex = base_vertex;
            test.add_iteration(spec.clone(), &format!("base vertex {base_vertex}"));
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `FirstGroup`
fn first_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    let firsts = [1, 3, 17];

    let mut group = TestCaseGroup::new(name);
    let mut spec = gen_basic_spec(method);

    for first in firsts {
        let mut test = DrawTestCase::new(format!("first_{first}"));

        spec.first = first;

        add_test_iterations(&mut test, &mut spec, TestIterationType::DrawCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `MethodGroup`
fn method_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    let indexed = method == DrawMethod::DrawElementsIndirect;
    let has_first = method == DrawMethod::DrawArraysIndirect;

    const PRIMITIVES: [Primitive; 7] = [
        Primitive::Points,
        Primitive::Triangles,
        Primitive::TriangleFan,
        Primitive::TriangleStrip,
        Primitive::Lines,
        Primitive::LineStrip,
        Primitive::LineLoop,
    ];

    let mut group = TestCaseGroup::new(name);

    if has_first {
        // First-tests
        group.add_child(first_group("first", method));
    }

    if indexed {
        // Index-tests
        group.add_child(index_group("indices", method));
        group.add_child(base_vertex_group("base_vertex", method));
    }

    for primitive in PRIMITIVES {
        group.add_child(attribute_group(
            primitive.to_str(),
            method,
            primitive,
            IndexType::Short,
            Storage::Buffer,
        ));
    }

    group
}

/// `RandomGroup::init`
fn random_group(name: &str) -> TestCaseGroup {
    const NUM_ATTEMPTS: i32 = 100;

    const ATTRIB_COUNTS: [i32; 3] = [1, 2, 5];
    const ATTRIB_WEIGHTS: [f32; 3] = [30.0, 10.0, 1.0];
    const PRIMITIVE_COUNTS: [i32; 3] = [1, 5, 64];
    const PRIMITIVE_COUNT_WEIGHTS: [f32; 3] = [20.0, 10.0, 1.0];
    const INDEX_OFFSETS: [i32; 3] = [0, 7, 13];
    const INDEX_OFFSET_WEIGHTS: [f32; 3] = [20.0, 20.0, 1.0];
    const FIRSTS: [i32; 3] = [0, 7, 13];
    const FIRST_WEIGHTS: [f32; 3] = [20.0, 20.0, 1.0];

    const INSTANCE_COUNTS: [i32; 4] = [1, 2, 16, 17];
    const INSTANCE_WEIGHTS: [f32; 4] = [20.0, 10.0, 5.0, 1.0];
    const INDEX_MINS: [i32; 4] = [0, 1, 3, 8];
    const INDEX_MAXS: [i32; 4] = [4, 8, 128, 257];
    const INDEX_WEIGHTS: [f32; 4] = [50.0, 50.0, 50.0, 50.0];
    const OFFSETS: [i32; 4] = [0, 1, 5, 12];
    const OFFSET_WEIGHTS: [f32; 4] = [50.0, 10.0, 10.0, 10.0];
    const STRIDES: [i32; 4] = [0, 7, 16, 17];
    const STRIDE_WEIGHTS: [f32; 4] = [50.0, 10.0, 10.0, 10.0];
    const INSTANCE_DIVISORS: [i32; 4] = [0, 1, 3, 129];
    const INSTANCE_DIVISOR_WEIGHTS: [f32; 4] = [70.0, 30.0, 10.0, 10.0];

    const INDIRECT_OFFSETS: [i32; 3] = [0, 1, 2];
    const INDIRECT_OFFSET_WEIGHTS: [f32; 3] = [2.0, 1.0, 1.0];
    const BASE_VERTICES: [i32; 5] = [0, 1, -2, 4, 3];
    const BASE_VERTEX_WEIGHTS: [f32; 5] = [4.0, 1.0, 1.0, 1.0, 1.0];

    const PRIMITIVES: [Primitive; 7] = [
        Primitive::Points,
        Primitive::Triangles,
        Primitive::TriangleFan,
        Primitive::TriangleStrip,
        Primitive::Lines,
        Primitive::LineStrip,
        Primitive::LineLoop,
    ];
    const PRIMITIVE_WEIGHTS: [f32; 7] = [1.0; 7];

    const DRAW_METHODS: [DrawMethod; 2] = [DrawMethod::DrawArraysIndirect, DrawMethod::DrawElementsIndirect];
    const DRAW_METHOD_WEIGHTS: [f32; 2] = [1.0; 2];

    const INDEX_TYPES: [IndexType; 3] = [IndexType::Byte, IndexType::Short, IndexType::Int];
    const INDEX_TYPE_WEIGHTS: [f32; 3] = [1.0; 3];

    const INPUT_TYPES: [InputType; 11] = [
        InputType::Float,
        InputType::Fixed,
        InputType::Byte,
        InputType::Short,
        InputType::UnsignedByte,
        InputType::UnsignedShort,
        InputType::Int,
        InputType::UnsignedInt,
        InputType::Half,
        InputType::UnsignedInt2_10_10_10,
        InputType::Int2_10_10_10,
    ];
    const INPUT_TYPE_WEIGHTS: [f32; 11] = [1.0; 11];

    const OUTPUT_TYPES: [OutputType; 12] = [
        OutputType::Float,
        OutputType::Vec2,
        OutputType::Vec3,
        OutputType::Vec4,
        OutputType::Int,
        OutputType::Uint,
        OutputType::IVec2,
        OutputType::IVec3,
        OutputType::IVec4,
        OutputType::UVec2,
        OutputType::UVec3,
        OutputType::UVec4,
    ];
    const OUTPUT_TYPE_WEIGHTS: [f32; 12] = [1.0; 12];

    const USAGES: [Usage; 9] = [
        Usage::DynamicDraw,
        Usage::StaticDraw,
        Usage::StreamDraw,
        Usage::StreamRead,
        Usage::StreamCopy,
        Usage::StaticRead,
        Usage::StaticCopy,
        Usage::DynamicRead,
        Usage::DynamicCopy,
    ];
    const USAGE_WEIGHTS: [f32; 9] = [1.0; 9];

    let mut group = TestCaseGroup::new(name);
    let mut inserted_hashes: HashSet<u32> = HashSet::new();
    let mut inserted_count = 0usize;
    let api_type = ApiType::es(3, 1);

    for ndx in 0..NUM_ATTEMPTS {
        let mut random = Random::new(0xc551393u32.wrapping_add(ndx as u32)); // random does not depend on previous cases

        let attribute_count = *random.choose_weighted(&ATTRIB_COUNTS, &ATTRIB_WEIGHTS);
        let mut spec = DrawTestSpec::new(api_type);

        spec.primitive = *random.choose_weighted(&PRIMITIVES, &PRIMITIVE_WEIGHTS);
        spec.primitive_count = *random.choose_weighted(&PRIMITIVE_COUNTS, &PRIMITIVE_COUNT_WEIGHTS);
        spec.draw_method = *random.choose_weighted(&DRAW_METHODS, &DRAW_METHOD_WEIGHTS);

        let draw_command_size = match spec.draw_method {
            DrawMethod::DrawArraysIndirect => 4 * 4,
            DrawMethod::DrawElementsIndirect => 5 * 4,
            _ => unreachable!("only the two indirect methods are drawn from"),
        };

        spec.index_type = *random.choose_weighted(&INDEX_TYPES, &INDEX_TYPE_WEIGHTS);
        spec.index_pointer_offset = *random.choose_weighted(&INDEX_OFFSETS, &INDEX_OFFSET_WEIGHTS);
        spec.index_storage = Storage::Buffer;
        spec.first = *random.choose_weighted(&FIRSTS, &FIRST_WEIGHTS);
        spec.index_min = *random.choose_weighted(&INDEX_MINS, &INDEX_WEIGHTS);
        spec.index_max = *random.choose_weighted(&INDEX_MAXS, &INDEX_WEIGHTS);
        spec.instance_count = *random.choose_weighted(&INSTANCE_COUNTS, &INSTANCE_WEIGHTS);
        spec.indirect_offset = *random.choose_weighted(&INDIRECT_OFFSETS, &INDIRECT_OFFSET_WEIGHTS) * draw_command_size;
        spec.base_vertex = *random.choose_weighted(&BASE_VERTICES, &BASE_VERTEX_WEIGHTS);

        // check spec is legal
        if !spec.valid() {
            continue;
        }

        let mut attr_ndx = 0;
        while attr_ndx < attribute_count {
            let input_type = *random.choose_weighted(&INPUT_TYPES, &INPUT_TYPE_WEIGHTS);
            let output_type = *random.choose_weighted(&OUTPUT_TYPES, &OUTPUT_TYPE_WEIGHTS);
            let usage = *random.choose_weighted(&USAGES, &USAGE_WEIGHTS);
            let component_count = random.get_int(1, 4);
            let offset = *random.choose_weighted(&OFFSETS, &OFFSET_WEIGHTS);
            let stride = *random.choose_weighted(&STRIDES, &STRIDE_WEIGHTS);
            let normalize = random.get_bool();
            let instance_divisor = *random.choose_weighted(&INSTANCE_DIVISORS, &INSTANCE_DIVISOR_WEIGHTS);
            let use_default_attribute = random.get_bool();

            let attrib_spec = AttributeSpec {
                input_type,
                output_type,
                storage: Storage::Buffer,
                usage,
                component_count,
                offset,
                stride,
                normalize,
                instance_divisor,
                use_default_attribute,
                ..Default::default()
            };

            // check spec is legal
            let mut valid = attrib_spec.valid(spec.api_type);

            // we do not want interleaved elements. (Might result in some weird floating point values)
            if attrib_spec.stride != 0
                && attrib_spec.component_count * attrib_spec.input_type.size() > attrib_spec.stride
            {
                valid = false;
            }

            // try again if not valid
            if valid {
                spec.attribs.push(attrib_spec);
                attr_ndx += 1;
            }
        }

        // Do not collapse all vertex positions to a single positions
        if spec.primitive != Primitive::Points {
            spec.attribs[0].instance_divisor = 0;
        }

        // Is render result meaningful?
        {
            // Only one vertex
            if spec.draw_method == DrawMethod::DrawElementsRanged
                && spec.index_min == spec.index_max
                && spec.primitive != Primitive::Points
            {
                continue;
            }
            if spec.attribs[0].use_default_attribute && spec.primitive != Primitive::Points {
                continue;
            }

            // Triangle only on one axis
            if matches!(
                spec.primitive,
                Primitive::Triangles | Primitive::TriangleFan | Primitive::TriangleStrip
            ) {
                if spec.attribs[0].component_count == 1 {
                    continue;
                }
                if matches!(
                    spec.attribs[0].output_type,
                    OutputType::Float | OutputType::Int | OutputType::Uint
                ) {
                    continue;
                }
                if spec.draw_method == DrawMethod::DrawElementsRanged && (spec.index_max - spec.index_min) < 2 {
                    continue;
                }
            }
        }

        // Add case
        {
            let mut hash = spec.hash() as u32;
            for attrib in spec.attribs.iter().take(attribute_count as usize) {
                hash = (hash << 2) ^ (attrib.hash() as u32);
            }

            if !inserted_hashes.contains(&hash) {
                // Only aligned cases
                let compatibility = spec.is_compatibility_test();
                if compatibility != CompatibilityTestType::UnalignedOffset
                    && compatibility != CompatibilityTestType::UnalignedStride
                {
                    let mut test = DrawTestCase::new(inserted_count.to_string());
                    test.add_iteration(spec.clone(), "");
                    group.add_child(Box::new(test) as Box<dyn TestCase>);
                }
                inserted_hashes.insert(hash);

                inserted_count += 1;
            }
        }
    }

    group
}

/// The `draw_arrays_indirect` and `draw_elements_indirect` method groups, in the order
/// `DrawTests::init` adds them.
pub fn create_basic_groups() -> Vec<TestCaseGroup> {
    const BASIC_METHODS: [DrawMethod; 2] = [DrawMethod::DrawArraysIndirect, DrawMethod::DrawElementsIndirect];

    BASIC_METHODS
        .iter()
        .map(|&method| method_group(method.to_str(), method))
        .collect()
}

/// `RandomGroup`, named `random`.
pub fn create_random_group() -> TestCaseGroup {
    random_group("random")
}
