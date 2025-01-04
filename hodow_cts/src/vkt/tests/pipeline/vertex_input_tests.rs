// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexInputTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `VertexInputTest` over `single_attribute`, `multiple_attributes`, `max_attributes` and
// `component_mismatch`. The cases are the table `vertex_input_cases.rs`, written by `scripts/gen_vertex_input_manifest.py` with the same loops
// and `de::Random` draws as `createSingleAttributeTests` and the other three; the same script replays `initPrograms` into
// `shaders/manifest/pipeline_vertex_input.toml`, one program per distinct vertex shader, found by the case's `key`. The format tables of
// `vktPipelineVertexUtil.cpp` are `vertex_input_formats.rs`. Upstream's check of VK_KHR_portability_subset's minimum stride alignment is not ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::vertex_input_cases::VERTEX_INPUT_CASES;
use super::vertex_input_formats::VERTEX_FORMATS;
use crate::generated::shaders::pipeline_vertex_input::ALL_SHARED_PROGRAM;
use crate::tcu::float::Float16;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages_specialized};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 16;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// One row of `vktPipelineVertexUtil.cpp`'s tables.
pub struct VertexFormatInfo {
    pub format: vk::Format,
    pub size: u32,
    pub component_count: u32,
    pub component_size: u32,
    pub packed_widths: [u32; 4],
    pub flags: u32,
}

impl VertexFormatInfo {
    pub const BGR: u32 = 1 << 0;
    pub const ABGR: u32 = 1 << 1;
    pub const ARGB: u32 = 1 << 2;
    pub const SINT: u32 = 1 << 3;
    pub const UINT: u32 = 1 << 4;
    pub const SFLOAT: u32 = 1 << 5;
    pub const UFLOAT: u32 = 1 << 6;
    pub const UNORM: u32 = 1 << 7;
    pub const SNORM: u32 = 1 << 8;
    pub const SRGB: u32 = 1 << 9;
    pub const SSCALED: u32 = 1 << 10;
    pub const USCALED: u32 = 1 << 11;
    pub const DOUBLE: u32 = 1 << 12;
    pub const PACKED: u32 = 1 << 13;

    fn has(&self, flag: u32) -> bool {
        self.flags & flag != 0
    }
}

fn format_info(format: vk::Format) -> &'static VertexFormatInfo {
    VERTEX_FORMATS
        .iter()
        .find(|info| info.format == format)
        .unwrap_or_else(|| panic!("{format:?} is not a vertex format of vktPipelineVertexUtil.cpp"))
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum GlslType {
    Int,
    Ivec2,
    Ivec3,
    Ivec4,
    Uint,
    Uvec2,
    Uvec3,
    Uvec4,
    Float,
    Vec2,
    Vec3,
    Vec4,
    F16,
    F16Vec2,
    F16Vec3,
    F16Vec4,
    Mat2,
    Mat3,
    Mat4,
    Double,
    Dvec2,
    Dvec3,
    Dvec4,
    Dmat2,
    Dmat3,
    Dmat4,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum GlslBasicType {
    Int,
    Uint,
    Float,
    Double,
    Float16,
}

/// `VertexInputTest::GlslTypeDescription`
struct GlslTypeDescription {
    vertex_input_component_count: u32,
    vertex_input_count: u32,
    basic_type: GlslBasicType,
}

const fn glsl_description(
    vertex_input_component_count: u32,
    vertex_input_count: u32,
    basic_type: GlslBasicType,
) -> GlslTypeDescription {
    GlslTypeDescription {
        vertex_input_component_count,
        vertex_input_count,
        basic_type,
    }
}

/// `VertexInputTest::s_glslTypeDescriptions`, in the order of `GlslType`.
static GLSL_TYPE_DESCRIPTIONS: [GlslTypeDescription; 26] = [
    glsl_description(1, 1, GlslBasicType::Int),
    glsl_description(2, 1, GlslBasicType::Int),
    glsl_description(3, 1, GlslBasicType::Int),
    glsl_description(4, 1, GlslBasicType::Int),
    glsl_description(1, 1, GlslBasicType::Uint),
    glsl_description(2, 1, GlslBasicType::Uint),
    glsl_description(3, 1, GlslBasicType::Uint),
    glsl_description(4, 1, GlslBasicType::Uint),
    glsl_description(1, 1, GlslBasicType::Float),
    glsl_description(2, 1, GlslBasicType::Float),
    glsl_description(3, 1, GlslBasicType::Float),
    glsl_description(4, 1, GlslBasicType::Float),
    glsl_description(1, 1, GlslBasicType::Float16),
    glsl_description(2, 1, GlslBasicType::Float16),
    glsl_description(3, 1, GlslBasicType::Float16),
    glsl_description(4, 1, GlslBasicType::Float16),
    glsl_description(2, 2, GlslBasicType::Float),
    glsl_description(3, 3, GlslBasicType::Float),
    glsl_description(4, 4, GlslBasicType::Float),
    glsl_description(1, 1, GlslBasicType::Double),
    glsl_description(2, 1, GlslBasicType::Double),
    glsl_description(3, 1, GlslBasicType::Double),
    glsl_description(4, 1, GlslBasicType::Double),
    glsl_description(2, 2, GlslBasicType::Double),
    glsl_description(3, 3, GlslBasicType::Double),
    glsl_description(4, 4, GlslBasicType::Double),
];

impl GlslType {
    fn description(self) -> &'static GlslTypeDescription {
        &GLSL_TYPE_DESCRIPTIONS[self as usize]
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BindingMapping {
    /// Vertex input bindings will not contain data for more than one attribute.
    OneToOne,
    /// Vertex input bindings can contain data for more than one attribute.
    OneToMany,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum AttributeLayout {
    /// Attribute data is bundled together as if in a structure: [pos 0][color 0][pos 1][color 1]...
    Interleaved,
    /// Data for each attribute is laid out separately: [pos 0][pos 1]...[color 0][color 1]...
    Sequential,
}

/// `VertexInputTest::AttributeInfo`
#[derive(Clone, Copy)]
pub struct AttributeInfo {
    pub glsl_type: GlslType,
    pub vk_type: vk::Format,
    pub input_rate: vk::VertexInputRate,
}

/// What one entry of `vertex_input_cases.rs` stands for: the arguments of one `VertexInputTest` constructor.
pub struct CaseSpec {
    pub path: &'static str,
    pub name: &'static str,
    pub key: &'static str,
    pub attributes: &'static [AttributeInfo],
    pub binding_mapping: BindingMapping,
    pub attribute_layout: AttributeLayout,
    pub layout_skip: bool,
    pub out_of_order: bool,
    pub missing_components: bool,
}

/// `isSupportedVertexFormat`
fn is_supported_vertex_format(context: &Context<'_>, format: vk::Format) -> bool {
    if format_info(format).has(VertexFormatInfo::DOUBLE) && context.get_device_features().shader_float64 == vk::FALSE {
        return false;
    }
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    properties
        .buffer_features
        .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
}

fn get_next_multiple_offset(divisor: u32, value: u32) -> u32 {
    if value.is_multiple_of(divisor) {
        0
    } else {
        divisor - (value % divisor)
    }
}

fn rate_value(rate: vk::VertexInputRate) -> u32 {
    u32::from(rate == vk::VertexInputRate::INSTANCE)
}

/// `getAttributeBinding`
fn get_attribute_binding(
    binding_mapping: BindingMapping,
    first_input_rate: vk::VertexInputRate,
    input_rate: vk::VertexInputRate,
    attribute_ndx: u32,
) -> u32 {
    match binding_mapping {
        BindingMapping::OneToOne => attribute_ndx,
        BindingMapping::OneToMany => (rate_value(first_input_rate) + rate_value(input_rate)) % 2,
    }
}

/// `getConsumedLocations`: the number of locations used up by an attribute.
fn get_consumed_locations(attribute_info: &AttributeInfo) -> u32 {
    let is_dmat = matches!(
        attribute_info.glsl_type,
        GlslType::Dmat2 | GlslType::Dmat3 | GlslType::Dmat4
    );
    if is_dmat
        && matches!(
            attribute_info.vk_type,
            vk::Format::R64G64B64_SFLOAT | vk::Format::R64G64B64A64_SFLOAT
        )
    {
        2
    } else {
        1
    }
}

/// `VertexInputInstance::VertexInputAttributeDescription`
#[derive(Clone)]
struct VertexInputAttributeDescription {
    glsl_type: GlslType,
    vertex_input_index: u32,
    vk_description: vk::VertexInputAttributeDescription,
}

fn write_bytes(dest: &mut [u8], offset: usize, bytes: &[u8]) {
    if let Some(target) = dest.get_mut(offset..offset + bytes.len()) {
        target.copy_from_slice(bytes);
    }
}

/// `writeVertexInputValueSint`
fn write_vertex_input_value_sint(dest: &mut [u8], format: vk::Format, component: u32, value: i32) {
    let component_size = format_info(format).component_size;
    let offset = (component_size * component) as usize;
    match component_size {
        1 => write_bytes(dest, offset, &(value as i8).to_le_bytes()),
        2 => write_bytes(dest, offset, &(value as i16).to_le_bytes()),
        4 => write_bytes(dest, offset, &value.to_le_bytes()),
        _ => unreachable!("vertex component size {component_size}"),
    }
}

/// `writeVertexInputValueUint`
fn write_vertex_input_value_uint(dest: &mut [u8], format: vk::Format, component: u32, value: u32) {
    let component_size = format_info(format).component_size;
    let offset = (component_size * component) as usize;
    match component_size {
        1 => write_bytes(dest, offset, &(value as u8).to_le_bytes()),
        2 => write_bytes(dest, offset, &(value as u16).to_le_bytes()),
        4 => write_bytes(dest, offset, &value.to_le_bytes()),
        _ => unreachable!("vertex component size {component_size}"),
    }
}

/// `writeVertexInputValueIntPacked`
fn write_vertex_input_value_int_packed(
    dest: &mut [u8],
    packed_format: &mut u32,
    component_offset: &mut u32,
    format: vk::Format,
    component: u32,
    value: u32,
) {
    let info = format_info(format);
    let component_width = info.packed_widths[component as usize];
    let used_bits = !0u32 >> (info.size * 8 - component_width);

    *component_offset -= component_width;
    *packed_format |= (value & used_bits) << *component_offset;

    if component == info.component_count - 1 {
        write_bytes(dest, 0, &packed_format.to_le_bytes());
    }
}

/// `writeVertexInputValueSfloat`
fn write_vertex_input_value_sfloat(dest: &mut [u8], format: vk::Format, component: u32, value: f32) {
    let component_size = format_info(format).component_size;
    let offset = (component_size * component) as usize;
    match component_size {
        2 => write_bytes(dest, offset, &Float16::new(value).bits().to_le_bytes()),
        4 => write_bytes(dest, offset, &value.to_le_bytes()),
        _ => unreachable!("vertex component size {component_size}"),
    }
}

/// `writeVertexInputValueUfloat`: only B10G11R11_UFLOAT_PACK32 exists, and its fields have no sign bit but the exponent bits of a float16.
fn write_vertex_input_value_ufloat(
    dest: &mut [u8],
    packed_format: &mut u32,
    component_offset: &mut u32,
    format: vk::Format,
    component: u32,
    value: f32,
) {
    let f16 = Float16::new(value);
    let info = format_info(format);
    let component_width = info.packed_widths[component as usize];
    let used_bits = !0u32 >> (info.size * 8 - component_width);
    let value_ufloat = u32::from(f16.bits()) >> (16 - component_width - 1);

    *component_offset -= component_width;
    *packed_format |= (value_ufloat & used_bits) << *component_offset;

    if component == info.component_count - 1 {
        write_bytes(dest, 0, &packed_format.to_le_bytes());
    }
}

/// `VertexInputInstance::writeVertexInputValue`; `dest` starts at the attribute's offset.
fn write_vertex_input_value(dest: &mut [u8], attribute: &VertexInputAttributeDescription, index_id: u32) {
    let description = attribute.glsl_type.description();
    let vertex_input_count = description.vertex_input_count;
    let component_count = description.vertex_input_component_count;
    let total_component_count = component_count * vertex_input_count;
    let vertex_input_index = index_id * total_component_count + attribute.vertex_input_index * component_count;
    let format = attribute.vk_description.format;
    let info = format_info(format);
    let is_packed = info.has(VertexFormatInfo::PACKED);
    let mut component_offset = info.size * 8;
    let mut packed_format32 = 0u32;

    const BGR_SWIZZLE: [u32; 4] = [2, 1, 0, 3];
    const ABGR_SWIZZLE: [u32; 4] = [3, 2, 1, 0];
    const ARGB_SWIZZLE: [u32; 4] = [3, 0, 1, 2];

    for component in 0..component_count {
        let swizzled = if info.has(VertexFormatInfo::ABGR) {
            ABGR_SWIZZLE[component as usize]
        } else if info.has(VertexFormatInfo::ARGB) {
            ARGB_SWIZZLE[component as usize]
        } else if info.has(VertexFormatInfo::BGR) {
            BGR_SWIZZLE[component as usize]
        } else {
            component
        };

        let max_int_value: i32 = if is_packed {
            1i32.wrapping_shl(info.packed_widths[component as usize].wrapping_sub(1))
                .wrapping_sub(1)
        } else {
            1i32.wrapping_shl((info.component_size * 8).wrapping_sub(1))
                .wrapping_sub(1)
        };
        let max_uint_value: i32 = if is_packed {
            1i32.wrapping_shl(info.packed_widths[component as usize])
                .wrapping_sub(1)
        } else {
            1i32.wrapping_shl(info.component_size * 8).wrapping_sub(1)
        };
        let min_int_value = max_int_value.wrapping_neg();
        let min_uint_value = 0i32;
        let sum = vertex_input_index + swizzled;

        match attribute.glsl_type.description().basic_type {
            GlslBasicType::Int => {
                if is_packed {
                    let value = (-(sum as i32)).clamp(min_int_value, max_int_value);
                    write_vertex_input_value_int_packed(
                        dest,
                        &mut packed_format32,
                        &mut component_offset,
                        format,
                        component,
                        value as u32,
                    );
                } else {
                    write_vertex_input_value_sint(dest, format, component, -(sum as i32));
                }
            }
            GlslBasicType::Uint => {
                if is_packed {
                    let value = (sum as i32).clamp(min_uint_value, max_uint_value);
                    write_vertex_input_value_int_packed(
                        dest,
                        &mut packed_format32,
                        &mut component_offset,
                        format,
                        component,
                        value as u32,
                    );
                } else {
                    write_vertex_input_value_uint(dest, format, component, sum);
                }
            }
            GlslBasicType::Float | GlslBasicType::Float16 => {
                if info.has(VertexFormatInfo::SFLOAT) {
                    write_vertex_input_value_sfloat(dest, format, component, -(0.01f32 * sum as f32));
                } else if info.has(VertexFormatInfo::UFLOAT) {
                    write_vertex_input_value_ufloat(
                        dest,
                        &mut packed_format32,
                        &mut component_offset,
                        format,
                        component,
                        0.01f32 * sum as f32,
                    );
                } else if info.has(VertexFormatInfo::SSCALED) {
                    if is_packed {
                        let value = (-(sum as i32)).clamp(min_int_value, max_int_value);
                        write_vertex_input_value_int_packed(
                            dest,
                            &mut packed_format32,
                            &mut component_offset,
                            format,
                            component,
                            value as u32,
                        );
                    } else {
                        write_vertex_input_value_sint(dest, format, component, -(sum as i32));
                    }
                } else if info.has(VertexFormatInfo::USCALED)
                    || info.has(VertexFormatInfo::UNORM)
                    || info.has(VertexFormatInfo::SRGB)
                {
                    if is_packed {
                        let value = (sum as i32).clamp(min_uint_value, max_uint_value);
                        write_vertex_input_value_int_packed(
                            dest,
                            &mut packed_format32,
                            &mut component_offset,
                            format,
                            component,
                            value as u32,
                        );
                    } else {
                        write_vertex_input_value_uint(dest, format, component, sum);
                    }
                } else if info.has(VertexFormatInfo::SNORM) {
                    let raw = min_int_value.wrapping_add(sum as i32);
                    if is_packed {
                        let value = raw.clamp(min_int_value, max_int_value);
                        write_vertex_input_value_int_packed(
                            dest,
                            &mut packed_format32,
                            &mut component_offset,
                            format,
                            component,
                            value as u32,
                        );
                    } else {
                        write_vertex_input_value_sint(dest, format, component, raw);
                    }
                } else {
                    unreachable!("unclassified vertex format {format:?}");
                }
            }
            GlslBasicType::Double => {
                let value = -0.01f64 * f64::from(sum);
                write_bytes(dest, (component * 8) as usize, &value.to_le_bytes());
            }
        }
    }
}

/// `VertexInputInstance::writeVertexInputData`
fn write_vertex_input_data(
    dest: &mut [u8],
    binding: &vk::VertexInputBindingDescription,
    binding_offset: u64,
    attributes: &[VertexInputAttributeDescription],
) {
    let vertex_count = if binding.input_rate == vk::VertexInputRate::VERTEX {
        4 * 2
    } else {
        2
    };
    let mut dest_offset = binding_offset as usize;
    for vertex in 0..vertex_count {
        for attribute in attributes {
            if attribute.vk_description.binding == binding.binding {
                let start = dest_offset + attribute.vk_description.offset as usize;
                if start <= dest.len() {
                    write_vertex_input_value(&mut dest[start..], attribute, vertex);
                }
            }
        }
        dest_offset += binding.stride as usize;
    }
}

/// `VertexInputTest`
struct VertexInputCase {
    spec: &'static CaseSpec,
    construction: PipelineConstructionType,
}

impl VertexInputCase {
    fn uses_float16(&self) -> bool {
        self.spec
            .attributes
            .iter()
            .any(|attribute| attribute.glsl_type.description().basic_type == GlslBasicType::Float16)
    }

    fn query_max_attributes(&self) -> bool {
        self.spec.attributes.is_empty()
    }
}

/// The location slots of the constructor of `VertexInputTest`, for a case that names its attributes.
fn assign_locations(spec: &CaseSpec) -> Vec<u32> {
    let mut attribute_location = 0u32;
    let mut location_slots_needed = Vec::new();
    for attribute_info in spec.attributes {
        let previous = attribute_location;
        attribute_location +=
            attribute_info.glsl_type.description().vertex_input_count * get_consumed_locations(attribute_info);
        if spec.layout_skip {
            attribute_location += 1;
        }
        location_slots_needed.push(attribute_location - previous);
    }

    let num_attributes = spec.attributes.len();
    if !spec.out_of_order {
        let mut loc = 0;
        let mut locations = Vec::new();
        for needed in &location_slots_needed {
            locations.push(loc);
            loc += needed;
        }
        return locations;
    }

    // Mix the location slots: first all even and then all odd attributes.
    let indices: Vec<usize> = (0..num_attributes)
        .filter(|i| i % 2 == 0)
        .chain((0..num_attributes).filter(|i| i % 2 != 0))
        .collect();
    let mut slots = Vec::new();
    let mut slot = 0;
    for &index in &indices {
        slots.push(slot);
        slot += location_slots_needed[index];
    }
    (0..num_attributes)
        .map(|attribute_ndx| {
            let mut slot_idx = 0;
            for (i, &index) in indices.iter().enumerate() {
                if attribute_ndx == index {
                    slot_idx = i;
                }
            }
            slots[slot_idx]
        })
        .collect()
}

impl TestCase for VertexInputCase {
    fn name(&self) -> &str {
        self.spec.name
    }

    /// `VertexInputTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let max_attributes = context.get_device_properties().limits.max_vertex_input_attributes;
        if self.spec.attributes.len() as u32 > max_attributes {
            return Err(TestError::NotSupported(format!(
                "Unsupported number of vertex input attributes, maxVertexInputAttributes: {max_attributes}"
            )));
        }

        if self.uses_float16() {
            let mut float16_int8 = vk::PhysicalDeviceShaderFloat16Int8Features::default();
            let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut float16_int8)
                    .push_next(&mut storage16);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if float16_int8.shader_float16 == vk::FALSE {
                return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
            }
            if storage16.storage_input_output16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "storageInputOutput16 not supported".to_string(),
                ));
            }
        }

        check_pipeline_construction_requirements(context, self.construction)
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.spec.key)
            .map(|program| program.programs)
            .unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexInputInstance { context, case: self })
    }
}

struct VertexInputInstance<'a> {
    context: &'a Context<'a>,
    case: &'a VertexInputCase,
}

/// What `VertexInputTest::createInstance` hands to `VertexInputInstance`.
struct VertexInputLayout {
    attribute_descriptions: Vec<VertexInputAttributeDescription>,
    binding_descriptions: Vec<vk::VertexInputBindingDescription>,
    binding_offsets: Vec<u64>,
}

impl VertexInputInstance<'_> {
    /// `VertexInputTest::createInstance`: the binding and attribute descriptions with their offsets and strides.
    fn describe(&self) -> Result<VertexInputLayout, TestError> {
        let spec = self.case.spec;
        let query_max = self.case.query_max_attributes();
        let limits = &self.context.get_device_properties().limits;
        let max_attributes = limits.max_vertex_input_attributes as usize;

        let locations: Vec<u32> = if query_max {
            (0..max_attributes as u32).collect()
        } else {
            assign_locations(spec)
        };
        let num_attributes = if query_max {
            max_attributes
        } else {
            spec.attributes.len()
        };
        let attribute_info = |attribute_ndx: usize| -> AttributeInfo {
            if query_max {
                AttributeInfo {
                    glsl_type: GlslType::Vec4,
                    vk_type: vk::Format::R8G8B8A8_SNORM,
                    input_rate: if attribute_ndx % 2 == 0 {
                        vk::VertexInputRate::VERTEX
                    } else {
                        vk::VertexInputRate::INSTANCE
                    },
                }
            } else {
                spec.attributes[attribute_ndx]
            }
        };

        let num_bindings = match spec.binding_mapping {
            BindingMapping::OneToOne => num_attributes,
            BindingMapping::OneToMany => {
                if num_attributes > 1 {
                    2
                } else {
                    1
                }
            }
        };
        let first_input_rate = attribute_info(0).input_rate;

        let mut binding_descriptions = Vec::new();
        let mut binding_offsets = Vec::new();
        for binding_ndx in 0..num_bindings {
            // Bindings alternate between STEP_RATE_VERTEX and STEP_RATE_INSTANCE
            let input_rate = if (rate_value(first_input_rate) + binding_ndx as u32) % 2 == 0 {
                vk::VertexInputRate::VERTEX
            } else {
                vk::VertexInputRate::INSTANCE
            };
            // Stride will be updated when creating the attribute descriptions
            binding_descriptions.push(vk::VertexInputBindingDescription {
                binding: binding_ndx as u32,
                stride: 0,
                input_rate,
            });
            binding_offsets.push(4 * binding_ndx as u64);
        }

        let mut attribute_descriptions = Vec::new();
        let mut attribute_offsets = vec![0u32; binding_descriptions.len()];
        // Max component or vector size, depending on which layout we are using
        let mut attribute_max_sizes = vec![0u32; binding_descriptions.len()];
        let mut attribute_max_comp_sizes = vec![0u32; binding_descriptions.len()];
        // Strides for bindings in sequential layout mode
        let mut binding_seq_strides = vec![0u32; binding_descriptions.len()];

        // To place the attributes sequentially we need to know the largest attribute and use its size in stride and offset calculations.
        if spec.attribute_layout == AttributeLayout::Sequential {
            for attribute_ndx in 0..num_attributes {
                let info = attribute_info(attribute_ndx);
                let binding = get_attribute_binding(
                    spec.binding_mapping,
                    first_input_rate,
                    info.input_rate,
                    attribute_ndx as u32,
                ) as usize;
                let format = format_info(info.vk_type);
                attribute_max_sizes[binding] = attribute_max_sizes[binding].max(format.size);
                attribute_max_comp_sizes[binding] = attribute_max_comp_sizes[binding].max(format.component_size);
            }

            // Round up the maximum size so the components are always aligned.
            for binding_idx in 0..binding_seq_strides.len() {
                let component_size = attribute_max_comp_sizes[binding_idx];
                binding_seq_strides[binding_idx] =
                    attribute_max_sizes[binding_idx].div_ceil(component_size) * component_size;
            }
        }

        // Create attribute descriptions, assign them to bindings and update stride.
        for attribute_ndx in 0..num_attributes {
            let info = attribute_info(attribute_ndx);
            let glsl_type_description = info.glsl_type.description();
            let input_size = format_info(info.vk_type).size;
            let attribute_binding = get_attribute_binding(
                spec.binding_mapping,
                first_input_rate,
                info.input_rate,
                attribute_ndx as u32,
            ) as usize;
            let vertex_count = if info.input_rate == vk::VertexInputRate::VERTEX {
                4 * 2
            } else {
                2
            };

            let mut attribute_description = VertexInputAttributeDescription {
                glsl_type: info.glsl_type,
                vertex_input_index: 0,
                vk_description: vk::VertexInputAttributeDescription {
                    location: 0,
                    binding: attribute_binding as u32,
                    format: info.vk_type,
                    offset: 0,
                },
            };

            // Matrix types add each column as a separate attribute.
            for desc_ndx in 0..glsl_type_description.vertex_input_count {
                attribute_description.vertex_input_index = desc_ndx;
                attribute_description.vk_description.location =
                    locations[attribute_ndx] + get_consumed_locations(&info) * desc_ndx;

                if spec.attribute_layout == AttributeLayout::Interleaved {
                    let offset_to_component_alignment = get_next_multiple_offset(
                        input_size,
                        binding_offsets[attribute_binding] as u32 + attribute_offsets[attribute_binding],
                    );

                    attribute_offsets[attribute_binding] += offset_to_component_alignment;

                    attribute_description.vk_description.offset = attribute_offsets[attribute_binding];
                    attribute_descriptions.push(attribute_description.clone());

                    binding_descriptions[attribute_binding].stride += offset_to_component_alignment + input_size;
                    attribute_offsets[attribute_binding] += input_size;
                    attribute_max_sizes[attribute_binding] = attribute_max_sizes[attribute_binding].max(input_size);
                } else {
                    attribute_description.vk_description.offset = attribute_offsets[attribute_binding];
                    attribute_descriptions.push(attribute_description.clone());

                    attribute_offsets[attribute_binding] += vertex_count * binding_seq_strides[attribute_binding];
                }
            }

            if spec.attribute_layout == AttributeLayout::Sequential {
                binding_descriptions[attribute_binding].stride = binding_seq_strides[attribute_binding];
            }
        }

        if spec.attribute_layout == AttributeLayout::Interleaved {
            // Make sure the stride results in aligned access
            for binding_ndx in 0..binding_descriptions.len() {
                let stride = &mut binding_descriptions[binding_ndx].stride;
                if attribute_max_sizes[binding_ndx] > 0 {
                    *stride += get_next_multiple_offset(attribute_max_sizes[binding_ndx], *stride);
                }
            }
        }

        // Check upfront for maximum number of vertex input bindings
        let max_bindings = limits.max_vertex_input_bindings;
        if binding_descriptions.len() as u32 > max_bindings {
            return Err(TestError::NotSupported(format!(
                "Unsupported number of vertex input bindings, maxVertexInputBindings: {max_bindings}"
            )));
        }

        Ok(VertexInputLayout {
            attribute_descriptions,
            binding_descriptions,
            binding_offsets,
        })
    }

    /// `VertexInputInstance::verifyImage`: the left half is red, the right half blue, compared with `intThresholdPositionDeviationCompare`
    /// at a threshold of 2 and a deviation of one pixel, the border pixels accepted as anything.
    fn verify_image(result: &[u8]) -> bool {
        let size = RENDER_SIZE as i32;
        let reference = |x: i32, _y: i32| -> [u8; 4] {
            if x < size / 2 {
                [255, 0, 0, 255]
            } else {
                [0, 0, 255, 255]
            }
        };
        let pixel = |x: i32, y: i32| -> [u8; 4] {
            let start = ((y * size + x) * 4) as usize;
            [result[start], result[start + 1], result[start + 2], result[start + 3]]
        };
        let within = |a: [u8; 4], b: [u8; 4]| (0..4).all(|c| a[c].abs_diff(b[c]) <= 2);
        let nearby = |x: i32, y: i32| (-1..=1).flat_map(move |dy| (-1..=1).map(move |dx| (x + dx, y + dy)));

        for y in 1..size - 1 {
            for x in 1..size - 1 {
                let result_found = nearby(x, y).any(|(sx, sy)| within(pixel(x, y), reference(sx, sy)));
                let reference_found = nearby(x, y).any(|(sx, sy)| within(reference(x, y), pixel(sx, sy)));
                if !result_found || !reference_found {
                    return false;
                }
            }
        }
        true
    }
}

impl TestInstance for VertexInputInstance<'_> {
    /// `VertexInputInstance`'s constructor and `iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let layout = self.describe()?;

        // Check upfront for unsupported features
        for attribute in &layout.attribute_descriptions {
            let format = attribute.vk_description.format;
            if !is_supported_vertex_format(context, format) {
                return Err(TestError::NotSupported(format!(
                    "Unsupported format for vertex input: {format:?}"
                )));
            }
        }

        let color_buffer = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            COLOR_FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("attribute_test_vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("attribute_test_frag")?)?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = layout.binding_descriptions.clone();
        state.attributes = layout
            .attribute_descriptions
            .iter()
            .map(|attribute| attribute.vk_description)
            .collect();
        state.vertex_specialization_u32 = Some(layout.attribute_descriptions.len() as u32);
        state.construction = self.case.construction;
        let specialization_entries = [vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: 4,
        }];
        let specialization_data = (layout.attribute_descriptions.len() as u32).to_ne_bytes();
        let shader_objects = make_shader_objects_stages_specialized(
            context,
            &[
                (vk::ShaderStageFlags::VERTEX, "attribute_test_vert"),
                (vk::ShaderStageFlags::FRAGMENT, "attribute_test_frag"),
            ],
            &[],
            &[],
            Some((&specialization_entries, &specialization_data)),
        )?;
        let pipeline = if shader_objects.is_none() {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        } else {
            None
        };

        let buffer_size = 32 * 8 * layout.attribute_descriptions.len();
        let mut vertex_buffers = Vec::new();
        for (binding, &binding_offset) in layout.binding_descriptions.iter().zip(&layout.binding_offsets) {
            let mut data = vec![0u8; buffer_size];
            write_vertex_input_data(&mut data, binding, binding_offset, &layout.attribute_descriptions);
            vertex_buffers.push(create_host_buffer(context, &data, vk::BufferUsageFlags::VERTEX_BUFFER)?);
        }
        let buffer_handles: Vec<vk::Buffer> = vertex_buffers.iter().map(|buffer| buffer.get()).collect();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.125, 0.25, 0.75, 1.0])];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| pipeline.get()),
            *render_pass,
            *framebuffer,
            rect_2d(RENDER_SIZE, RENDER_SIZE),
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            if buffer_handles.len() <= 1 {
                device.cmd_bind_vertex_buffers(cmd, 0, &buffer_handles, &layout.binding_offsets);
            } else {
                let first_half_length = buffer_handles.len() / 2;
                device.cmd_bind_vertex_buffers(
                    cmd,
                    0,
                    &buffer_handles[..first_half_length],
                    &layout.binding_offsets[..first_half_length],
                );
                device.cmd_bind_vertex_buffers(
                    cmd,
                    first_half_length as u32,
                    &buffer_handles[first_half_length..],
                    &layout.binding_offsets[first_half_length..],
                );
            }

            device.cmd_draw(cmd, 4, 2, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        if Self::verify_image(color_buffer.read_bytes(device)?) {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

enum Node {
    Case(&'static CaseSpec),
    Group(Vec<(&'static str, Node)>),
}

fn insert_case(children: &mut Vec<(&'static str, Node)>, path: &[&'static str], spec: &'static CaseSpec) {
    match path.split_first() {
        None => children.push((spec.name, Node::Case(spec))),
        Some((&head, rest)) => {
            let position = match children
                .iter()
                .position(|(name, node)| *name == head && matches!(node, Node::Group(_)))
            {
                Some(position) => position,
                None => {
                    children.push((head, Node::Group(Vec::new())));
                    children.len() - 1
                }
            };
            if let Node::Group(grandchildren) = &mut children[position].1 {
                insert_case(grandchildren, rest, spec);
            }
        }
    }
}

fn build_group(name: &str, children: &[(&'static str, Node)], construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for (child_name, node) in children {
        match node {
            Node::Case(spec) => {
                group.add_child(Box::new(VertexInputCase { spec, construction }) as Box<dyn TestCase>);
            }
            Node::Group(grandchildren) => {
                group.add_child(build_group(child_name, grandchildren, construction));
            }
        }
    }
    group
}

/// `createSingleAttributeTests`, `createMultipleAttributeTests`, `createMaxAttributeTests` and `createComponentMismatchTests`, added to the
/// `vertex_input` group in the order `createVertexInputTests` adds them; the two with several attributes are not built with shader objects.
pub fn add_vertex_input_attribute_tests(vertex_input: &mut TestCaseGroup, construction: PipelineConstructionType) {
    let mut roots: Vec<(&'static str, Node)> = Vec::new();
    for spec in VERTEX_INPUT_CASES.iter() {
        let path: Vec<&'static str> = spec.path.split('/').collect();
        insert_case(&mut roots, &path, spec);
    }
    let order = [
        "single_attribute",
        "multiple_attributes",
        "max_attributes",
        "component_mismatch",
    ];
    for wanted in order {
        if construction.is_shader_object() && matches!(wanted, "multiple_attributes" | "max_attributes") {
            continue;
        }
        if let Some((name, Node::Group(children))) = roots.iter().find(|(name, _)| *name == wanted) {
            vertex_input.add_child(build_group(name, children, construction));
        }
    }
}
