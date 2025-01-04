// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcUniformBlockTests.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As in `gles3::functional::uniform_block_tests`, upstream's `UniformBlockCase` subclasses each exist only to fill `m_interface`, so each becomes a function that builds the same
// `ShaderInterface` at registration time. Compared with the ES copy the Khronos one takes the GLSL version as a parameter, has no `single_nested_struct_mixed_matrix_packing` group, declares the shader stages per layout rather than
// registering `_vertex`/`_fragment`/`_both` triples, and keeps the single-struct groups flat. `common` registers only `name_matching`: `UniformBlockPrecisionMatching` is added only when the context supports GLSL ES 3.00, and every root
// here is a desktop one.

mod case;
mod negative;

use self::case::UniformBlockCase;
pub use self::negative::create_tests as create_negative_tests;
use crate::gls::random_uniform_block_case::{
    FEATURE_ARRAYS, FEATURE_ARRAYS_OF_ARRAYS, FEATURE_FRAGMENT_BLOCKS, FEATURE_INSTANCE_ARRAYS, FEATURE_MATRICES,
    FEATURE_MATRIX_LAYOUT, FEATURE_PACKED_LAYOUT, FEATURE_SHARED_BLOCKS, FEATURE_SHARED_LAYOUT, FEATURE_STD140_LAYOUT,
    FEATURE_STRUCTS, FEATURE_UNUSED_MEMBERS, FEATURE_UNUSED_UNIFORMS, FEATURE_VECTORS, FEATURE_VERTEX_BLOCKS,
    generate_interface,
};
use crate::gls::uniform_block_case::{
    BufferMode, DECLARE_BOTH, DECLARE_FRAGMENT, DECLARE_VERTEX, LAYOUT_COLUMN_MAJOR, LAYOUT_PACKED, LAYOUT_ROW_MAJOR,
    LAYOUT_SHARED, LAYOUT_STD140, PRECISION_HIGH, PRECISION_LOW, PRECISION_MEDIUM, ShaderInterface, StructType,
    UNUSED_BOTH, Uniform, UniformBlock, VarType,
};
use crate::glu::shader_util::DataType;
use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::tcu::random::de_int32_hash;
use crate::tcu::{TestOutcome, TestStatus};

/// `basicTypes[]`
const BASIC_TYPES: [DataType; 25] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    DataType::FloatMat2,
    DataType::FloatMat3,
    DataType::FloatMat4,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
];

const PRECISION_FLAGS: [(&str, u32); 3] = [
    ("lowp", PRECISION_LOW),
    ("mediump", PRECISION_MEDIUM),
    ("highp", PRECISION_HIGH),
];
const LAYOUT_FLAGS: [(&str, u32); 3] = [
    ("shared", LAYOUT_SHARED),
    ("packed", LAYOUT_PACKED),
    ("std140", LAYOUT_STD140),
];
const MATRIX_FLAGS: [(&str, u32); 2] = [("row_major", LAYOUT_ROW_MAJOR), ("column_major", LAYOUT_COLUMN_MAJOR)];
const BUFFER_MODES: [(&str, BufferMode); 2] = [
    ("per_block_buffer", BufferMode::PerBlock),
    ("single_buffer", BufferMode::Single),
];

/// Which upstream `UniformBlockCase` subclass builds the interface.
#[derive(Clone, Copy)]
enum InterfaceKind {
    /// `BlockBasicTypeCase`
    BasicType(VarTypeSpec),
    /// `BlockSingleStructCase`
    SingleStruct,
    /// `BlockSingleStructArrayCase`
    SingleStructArray,
    /// `BlockSingleNestedStructCase`
    SingleNestedStruct,
    /// `BlockSingleNestedStructArrayCase`
    SingleNestedStructArray,
    /// `BlockMultiBasicTypesCase` (flags A, flags B)
    MultiBasicTypes(u32, u32),
    /// `BlockMultiNestedStructCase` (flags A, flags B)
    MultiNestedStruct(u32, u32),
}

/// The `VarType` a `BlockBasicTypeCase` declares: a basic type, optionally wrapped in one array level.
#[derive(Clone, Copy)]
struct VarTypeSpec {
    basic_type: DataType,
    flags: u32,
    /// 0 means "not an array".
    array_size: i32,
}

impl VarTypeSpec {
    fn build(self) -> VarType {
        let basic = VarType::basic(self.basic_type, self.flags);
        if self.array_size > 0 {
            VarType::array(basic, self.array_size)
        } else {
            basic
        }
    }
}

/// The `S` struct three of the cases declare identically.
fn struct_s(interface: &mut ShaderInterface, b_type: DataType, a_unused: bool, c_unused: bool) -> VarType {
    let mut type_s = StructType::new("S");
    type_s.add_member(
        "a",
        VarType::basic(DataType::IntVec3, PRECISION_HIGH),
        if a_unused { UNUSED_BOTH } else { 0 },
    );
    type_s.add_member("b", VarType::array(VarType::basic(b_type, PRECISION_MEDIUM), 4), 0);
    type_s.add_member(
        "c",
        VarType::basic(DataType::FloatVec4, PRECISION_HIGH),
        if c_unused { UNUSED_BOTH } else { 0 },
    );
    VarType::structure(&interface.add_struct(type_s), 0)
}

/// Each subclass's `init`.
fn build_interface(kind: InterfaceKind, layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let finish = |interface: &mut ShaderInterface, mut block: UniformBlock, flags: u32| {
        block.flags = flags;
        if num_instances > 0 {
            block.array_size = num_instances;
            block.instance_name = Some("block".to_string());
        }
        interface.add_block(block);
    };

    match kind {
        InterfaceKind::BasicType(spec) => {
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("var", spec.build(), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleStruct => {
            let type_s = struct_s(&mut interface, DataType::FloatMat3, true, false);
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("s", type_s, 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleStructArray => {
            let type_s = struct_s(&mut interface, DataType::FloatMat3, true, false);
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_LOW), 0));
            block.add_uniform(Uniform::new("s", VarType::array(type_s, 3), 0));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec4, PRECISION_MEDIUM),
                0,
            ));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleNestedStruct => {
            let type_s = struct_s(&mut interface, DataType::FloatMat3, false, true);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM), 0);
            type_t.add_member("b", type_s.clone(), 0);
            let type_t = interface.add_struct(type_t);

            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("s", type_s, 0));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec2, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block.add_uniform(Uniform::new("t", VarType::structure(&type_t, 0), 0));
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_HIGH), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleNestedStructArray => {
            let type_s = struct_s(&mut interface, DataType::IntVec2, false, true);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM), 0);
            type_t.add_member("b", VarType::array(type_s.clone(), 3), 0);
            let type_t = interface.add_struct(type_t);

            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("s", type_s, 0));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec2, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block.add_uniform(Uniform::new("t", VarType::array(VarType::structure(&type_t, 0), 2), 0));
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_HIGH), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::MultiBasicTypes(flags_a, flags_b) => {
            let mut block_a = UniformBlock::new("BlockA");
            block_a.add_uniform(Uniform::new("a", VarType::basic(DataType::Float, PRECISION_HIGH), 0));
            block_a.add_uniform(Uniform::new(
                "b",
                VarType::basic(DataType::UintVec3, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block_a.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::FloatMat2, PRECISION_MEDIUM),
                0,
            ));
            block_a.instance_name = Some("blockA".to_string());
            block_a.flags = flags_a;

            let mut block_b = UniformBlock::new("BlockB");
            block_b.add_uniform(Uniform::new(
                "a",
                VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM),
                0,
            ));
            block_b.add_uniform(Uniform::new("b", VarType::basic(DataType::IntVec2, PRECISION_LOW), 0));
            block_b.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::FloatVec4, PRECISION_HIGH),
                UNUSED_BOTH,
            ));
            block_b.add_uniform(Uniform::new("d", VarType::basic(DataType::Bool, 0), 0));
            block_b.instance_name = Some("blockB".to_string());
            block_b.flags = flags_b;

            if num_instances > 0 {
                block_a.array_size = num_instances;
                block_b.array_size = num_instances;
            }

            interface.add_block(block_a);
            interface.add_block(block_b);
        }
        InterfaceKind::MultiNestedStruct(flags_a, flags_b) => {
            let mut type_s = StructType::new("S");
            type_s.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_LOW), 0);
            type_s.add_member(
                "b",
                VarType::array(VarType::basic(DataType::IntVec2, PRECISION_MEDIUM), 4),
                0,
            );
            type_s.add_member("c", VarType::basic(DataType::FloatVec4, PRECISION_HIGH), 0);
            let type_s = interface.add_struct(type_s);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::Uint, PRECISION_MEDIUM), UNUSED_BOTH);
            type_t.add_member("b", VarType::structure(&type_s, 0), 0);
            type_t.add_member("c", VarType::basic(DataType::BoolVec4, 0), 0);
            let type_t = interface.add_struct(type_t);

            let mut block_a = UniformBlock::new("BlockA");
            block_a.add_uniform(Uniform::new("a", VarType::basic(DataType::Float, PRECISION_HIGH), 0));
            block_a.add_uniform(Uniform::new("b", VarType::structure(&type_s, 0), 0));
            block_a.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::UintVec3, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block_a.instance_name = Some("blockA".to_string());
            block_a.flags = flags_a;

            let mut block_b = UniformBlock::new("BlockB");
            block_b.add_uniform(Uniform::new(
                "a",
                VarType::basic(DataType::FloatMat2, PRECISION_MEDIUM),
                0,
            ));
            block_b.add_uniform(Uniform::new("b", VarType::structure(&type_t, 0), 0));
            block_b.add_uniform(Uniform::new("c", VarType::basic(DataType::BoolVec4, 0), UNUSED_BOTH));
            block_b.add_uniform(Uniform::new("d", VarType::basic(DataType::Bool, 0), 0));
            block_b.instance_name = Some("blockB".to_string());
            block_b.flags = flags_b;

            if num_instances > 0 {
                block_a.array_size = num_instances;
                block_b.array_size = num_instances;
            }

            interface.add_block(block_a);
            interface.add_block(block_b);
        }
    }

    interface
}

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    glsl_version: GlslVersion,
    kind: InterfaceKind,
    layout_flags: u32,
    buffer_mode: BufferMode,
    num_instances: i32,
) {
    group.add_child(Box::new(UniformBlockCase {
        interface: build_interface(kind, layout_flags, num_instances),
        name,
        glsl_version,
        buffer_mode,
    }) as Box<dyn TestCase>);
}

/// The `DECLARE_*` bits the single-type groups add to a layout: a packed block can only be declared in one stage, which one alternating with the type's index.
fn basic_type_declare_flags(base_flags: u32, basic_type_ndx: usize) -> u32 {
    if base_flags & LAYOUT_PACKED != 0 {
        if basic_type_ndx.is_multiple_of(2) {
            DECLARE_VERTEX
        } else {
            DECLARE_FRAGMENT
        }
    } else {
        DECLARE_BOTH
    }
}

/// The `single_struct`/`single_struct_array`/`single_nested_struct`/`single_nested_struct_array` groups, which differ only in which interface they build and which stage a packed block goes to.
fn add_struct_group(
    parent: &mut TestCaseGroup,
    name: &str,
    glsl_version: GlslVersion,
    kind: InterfaceKind,
    packed_stage: u32,
) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        for (layout_name, base_flags) in LAYOUT_FLAGS {
            for is_array in 0..2 {
                let mut case_name = format!("{mode_name}_{layout_name}");
                let flags = base_flags
                    | if base_flags & LAYOUT_PACKED != 0 {
                        packed_stage
                    } else {
                        DECLARE_BOTH
                    };

                if buffer_mode == BufferMode::Single && is_array == 0 {
                    continue; // Doesn't make sense to add this variant.
                }

                if is_array == 1 {
                    case_name += "_instance_array";
                }

                add_case(
                    &mut group,
                    case_name,
                    glsl_version,
                    kind,
                    flags,
                    buffer_mode,
                    if is_array == 1 { 3 } else { 0 },
                );
            }
        }
    }

    parent.add_child(group);
}

/// The `multi_basic_types`/`multi_nested_struct` groups.
fn add_multi_group(
    parent: &mut TestCaseGroup,
    name: &str,
    glsl_version: GlslVersion,
    make_kind: fn(u32, u32) -> InterfaceKind,
) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        let mut mode_group = TestCaseGroup::new(mode_name);

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            for is_array in 0..2 {
                let base_name = if is_array == 1 {
                    format!("{layout_name}_instance_array")
                } else {
                    layout_name.to_string()
                };
                let num_instances = if is_array == 1 { 3 } else { 0 };

                add_case(
                    &mut mode_group,
                    format!("{base_name}_mixed"),
                    glsl_version,
                    make_kind(base_flags | DECLARE_VERTEX, base_flags | DECLARE_FRAGMENT),
                    0,
                    buffer_mode,
                    num_instances,
                );

                if base_flags & LAYOUT_PACKED == 0 {
                    add_case(
                        &mut mode_group,
                        format!("{base_name}_both"),
                        glsl_version,
                        make_kind(base_flags | DECLARE_BOTH, base_flags | DECLARE_BOTH),
                        0,
                        buffer_mode,
                        num_instances,
                    );
                }
            }
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

/// `createRandomCaseGroup`
fn create_random_case_group(
    parent: &mut TestCaseGroup,
    group_name: &str,
    glsl_version: GlslVersion,
    buffer_mode: BufferMode,
    features: u32,
    num_cases: i32,
    base_seed: i32,
) {
    let mut group = TestCaseGroup::new(group_name);

    for ndx in 0..num_cases {
        group.add_child(Box::new(UniformBlockCase {
            name: ndx.to_string(),
            glsl_version,
            buffer_mode,
            interface: generate_interface(features, de_int32_hash(ndx + base_seed)),
        }) as Box<dyn TestCase>);
    }

    parent.add_child(group);
}

/// `UniformBlockNameMatching`
struct UniformBlockNameMatching {
    glsl_version: GlslVersion,
}

impl UniformBlockNameMatching {
    /// `UniformBlockNameMatching::Test`
    fn test(&self, context: &Context, vs: &str, fs: &str, expected_link_status: bool) -> bool {
        let version = self.glsl_version.declaration();
        let sources = ProgramSources::vtx_frag(format!("{version}\n{vs}"), format!("{version}\n{fs}"));
        let program = ShaderProgram::new_expecting_build_failure(context.gl(), &sources);

        if let Some((shader_type, info)) = program.shader_info.iter().find(|(_, info)| !info.ok) {
            log::warn!(
                "{} compilation should succed. Info Log:\n{}",
                shader_type.as_str(),
                info.info_log
            );
            return false;
        }

        let link_status = program.program_info.ok;
        if link_status != expected_link_status {
            if link_status {
                log::warn!("Link operation should fail.");
            } else {
                log::warn!(
                    "Link operation should succed. Info Log:\n{}",
                    program.program_info.info_log
                );
            }
            return false;
        }

        true
    }
}

impl TestCase for UniformBlockNameMatching {
    fn name(&self) -> &str {
        "name_matching"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let fail = Ok(TestStatus::fail("Fail"));

        let vs1 = "precision highp float;\n\
                   layout (std140) uniform Data { vec4 v; };\n\
                   void main() {\n\
                   \x20 gl_Position = v;\n\
                   }";
        let fs1 = "precision highp float;\n\
                   out vec4 color;\n\
                   layout (std140) uniform Data { vec4 v; } myData;\n\
                   void main() {\n\
                   \x20 color = vec4(myData.v);\n\
                   }";

        // check if link error is generated when one of matched blocks has instance name and other doesn't
        if !self.test(context, vs1, fs1, false) {
            return fail;
        }

        let vs2 = "precision highp float;\n\
                   uniform Data { vec4 v; };\n\
                   void main() {\n\
                   \x20 gl_Position = v;\n\
                   }";
        let fs2 = "precision highp float;\n\
                   out vec4 color;\n\
                   uniform Data { vec4 v; };\n\
                   void main() {\n\
                   \x20 color = v;\n\
                   }";

        // check if linking succeeds when both matched blocks are lacking an instance name
        if !self.test(context, vs2, fs2, true) {
            return fail;
        }

        let vs3 = "precision highp float;\n\
                   layout (std140) uniform Data { vec4 v; } a;\n\
                   void main() {\n\
                   \x20 gl_Position = a.v;\n\
                   }";
        let fs3 = "precision highp float;\n\
                   out vec4 color;\n\
                   layout (std140) uniform Data { vec4 v; } b;\n\
                   void main() {\n\
                   \x20 color = b.v;\n\
                   }";

        // check if linking succeeds when both blocks have a different instance name
        if !self.test(context, vs3, fs3, true) {
            return fail;
        }

        let vs4 = "precision highp float;\n\
                   layout (std140) uniform Data { float f; };\n\
                   void main() {\n\
                   \x20 gl_Position = vec4(f);\n\
                   }\n";
        let fs4 = "precision highp float;\n\
                   uniform float f;\n\
                   out vec4 color;\n\
                   void main() {\n\
                   \x20 color = vec4(f);\n\
                   }\n";

        // check if link error is generated when the same name is used for block with no intance name and non-block uniform
        if !self.test(context, vs4, fs4, false) {
            return fail;
        }

        let vs5 = "precision highp float;\n\
                   layout (std140) uniform Data { float f; } a;\n\
                   void main() {\n\
                   \x20 gl_Position = vec4(a.f);\n\
                   }\n";
        let fs5 = "precision highp float;\n\
                   uniform float f;\n\
                   out vec4 color;\n\
                   void main() {\n\
                   \x20 color = vec4(f);\n\
                   }\n";

        // check if link succeeds when the same name is used for block with instance name and non-block uniform
        if !self.test(context, vs5, fs5, true) {
            return fail;
        }

        let vs6 = "precision highp float;\n\
                   uniform Data1 { float u; vec4 v; };\n\
                   void main() {\n\
                   \x20 gl_Position = v;\n\
                   }";
        let fs6 = "precision highp float;\n\
                   out vec4 color;\n\
                   uniform Data2 { vec4 v; };\n\
                   void main() {\n\
                   \x20 color = v;\n\
                   }";

        // check if link error is generated when same name is used in two different blocks
        if !self.test(context, vs6, fs6, false) {
            return fail;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `UniformBlockTests::init`
#[allow(clippy::too_many_lines)]
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("uniform_block");

    // uniform_block.single_basic_type
    {
        let mut single_basic_type_group = TestCaseGroup::new("single_basic_type");

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for (basic_type_ndx, ty) in BASIC_TYPES.into_iter().enumerate() {
                let type_name = ty.name();
                let flags = base_flags | basic_type_declare_flags(base_flags, basic_type_ndx);
                let spec = |flags: u32| VarTypeSpec {
                    basic_type: ty,
                    flags,
                    array_size: 0,
                };

                if ty.is_bool_or_bvec() {
                    add_case(
                        &mut layout_group,
                        type_name.to_string(),
                        glsl_version,
                        InterfaceKind::BasicType(spec(0)),
                        flags,
                        BufferMode::PerBlock,
                        0,
                    );
                } else {
                    for (prec_name, prec_flag) in PRECISION_FLAGS {
                        add_case(
                            &mut layout_group,
                            format!("{prec_name}_{type_name}"),
                            glsl_version,
                            InterfaceKind::BasicType(spec(prec_flag)),
                            flags,
                            BufferMode::PerBlock,
                            0,
                        );
                    }
                }

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        for (prec_name, prec_flag) in PRECISION_FLAGS {
                            add_case(
                                &mut layout_group,
                                format!("{mat_name}_{prec_name}_{type_name}"),
                                glsl_version,
                                InterfaceKind::BasicType(spec(prec_flag)),
                                flags | mat_flag,
                                BufferMode::PerBlock,
                                0,
                            );
                        }
                    }
                }
            }

            single_basic_type_group.add_child(layout_group);
        }

        group.add_child(single_basic_type_group);
    }

    // uniform_block.single_basic_array
    {
        let mut single_basic_array_group = TestCaseGroup::new("single_basic_array");
        const ARRAY_SIZE: i32 = 3;

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for (basic_type_ndx, ty) in BASIC_TYPES.into_iter().enumerate() {
                let type_name = ty.name();
                let flags = base_flags | basic_type_declare_flags(base_flags, basic_type_ndx);

                add_case(
                    &mut layout_group,
                    type_name.to_string(),
                    glsl_version,
                    InterfaceKind::BasicType(VarTypeSpec {
                        basic_type: ty,
                        flags: if ty.is_bool_or_bvec() { 0 } else { PRECISION_HIGH },
                        array_size: ARRAY_SIZE,
                    }),
                    flags,
                    BufferMode::PerBlock,
                    0,
                );

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        add_case(
                            &mut layout_group,
                            format!("{mat_name}_{type_name}"),
                            glsl_version,
                            InterfaceKind::BasicType(VarTypeSpec {
                                basic_type: ty,
                                flags: PRECISION_HIGH,
                                array_size: ARRAY_SIZE,
                            }),
                            flags | mat_flag,
                            BufferMode::PerBlock,
                            0,
                        );
                    }
                }
            }

            single_basic_array_group.add_child(layout_group);
        }

        group.add_child(single_basic_array_group);
    }

    add_struct_group(
        &mut group,
        "single_struct",
        glsl_version,
        InterfaceKind::SingleStruct,
        DECLARE_VERTEX,
    );
    add_struct_group(
        &mut group,
        "single_struct_array",
        glsl_version,
        InterfaceKind::SingleStructArray,
        DECLARE_FRAGMENT,
    );
    add_struct_group(
        &mut group,
        "single_nested_struct",
        glsl_version,
        InterfaceKind::SingleNestedStruct,
        DECLARE_VERTEX,
    );
    add_struct_group(
        &mut group,
        "single_nested_struct_array",
        glsl_version,
        InterfaceKind::SingleNestedStructArray,
        DECLARE_FRAGMENT,
    );

    // uniform_block.instance_array_basic_type
    {
        let mut instance_array_basic_type_group = TestCaseGroup::new("instance_array_basic_type");
        const NUM_INSTANCES: i32 = 3;

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for (basic_type_ndx, ty) in BASIC_TYPES.into_iter().enumerate() {
                let type_name = ty.name();
                let flags = base_flags | basic_type_declare_flags(base_flags, basic_type_ndx);

                add_case(
                    &mut layout_group,
                    type_name.to_string(),
                    glsl_version,
                    InterfaceKind::BasicType(VarTypeSpec {
                        basic_type: ty,
                        flags: if ty.is_bool_or_bvec() { 0 } else { PRECISION_HIGH },
                        array_size: 0,
                    }),
                    flags,
                    BufferMode::PerBlock,
                    NUM_INSTANCES,
                );

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        add_case(
                            &mut layout_group,
                            format!("{mat_name}_{type_name}"),
                            glsl_version,
                            InterfaceKind::BasicType(VarTypeSpec {
                                basic_type: ty,
                                flags: PRECISION_HIGH,
                                array_size: 0,
                            }),
                            flags | mat_flag,
                            BufferMode::PerBlock,
                            NUM_INSTANCES,
                        );
                    }
                }
            }

            instance_array_basic_type_group.add_child(layout_group);
        }

        group.add_child(instance_array_basic_type_group);
    }

    add_multi_group(
        &mut group,
        "multi_basic_types",
        glsl_version,
        InterfaceKind::MultiBasicTypes,
    );
    add_multi_group(
        &mut group,
        "multi_nested_struct",
        glsl_version,
        InterfaceKind::MultiNestedStruct,
    );

    // uniform_block.random
    {
        const ALL_SHADERS: u32 = FEATURE_VERTEX_BLOCKS | FEATURE_FRAGMENT_BLOCKS | FEATURE_SHARED_BLOCKS;
        const ALL_LAYOUTS: u32 = FEATURE_PACKED_LAYOUT | FEATURE_SHARED_LAYOUT | FEATURE_STD140_LAYOUT;
        const ALL_BASIC_TYPES: u32 = FEATURE_VECTORS | FEATURE_MATRICES;
        const UNUSED: u32 = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_UNIFORMS;
        const MAT_FLAGS: u32 = FEATURE_MATRIX_LAYOUT;
        // Upstream's `~0u`; the arrays-of-arrays bit does not exist in this copy.
        const ALL_FEATURES: u32 = !FEATURE_ARRAYS_OF_ARRAYS;

        let mut random_group = TestCaseGroup::new("random");
        let mut add = |name: &str, buffer_mode: BufferMode, features: u32, num_cases: i32, base_seed: i32| {
            create_random_case_group(
                &mut random_group,
                name,
                glsl_version,
                buffer_mode,
                features,
                num_cases,
                base_seed,
            );
        };

        // Basic types.
        add(
            "scalar_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED,
            10,
            0,
        );
        add(
            "vector_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | FEATURE_VECTORS,
            10,
            25,
        );
        add(
            "basic_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS,
            10,
            50,
        );
        add(
            "basic_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_ARRAYS,
            10,
            50,
        );

        add(
            "basic_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_INSTANCE_ARRAYS,
            10,
            75,
        );
        add(
            "nested_structs",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_STRUCTS,
            10,
            100,
        );
        add(
            "nested_structs_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_STRUCTS | FEATURE_ARRAYS,
            10,
            150,
        );
        add(
            "nested_structs_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS
                | ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | FEATURE_STRUCTS
                | FEATURE_INSTANCE_ARRAYS,
            10,
            125,
        );
        add(
            "nested_structs_arrays_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS
                | ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | FEATURE_STRUCTS
                | FEATURE_ARRAYS
                | FEATURE_INSTANCE_ARRAYS,
            10,
            175,
        );

        add("all_per_block_buffers", BufferMode::PerBlock, ALL_FEATURES, 20, 200);
        add("all_shared_buffer", BufferMode::Single, ALL_FEATURES, 20, 250);

        group.add_child(random_group);
    }

    // uniform_block.common
    {
        let mut common_group = TestCaseGroup::new("common");
        common_group.add_child(Box::new(UniformBlockNameMatching { glsl_version }) as Box<dyn TestCase>);
        group.add_child(common_group);
    }

    group
}
