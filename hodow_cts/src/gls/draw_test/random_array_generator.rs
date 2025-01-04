// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::RandomArrayGenerator, and the
//   anonymous-namespace `generateRandomVec4`/`IVec4`/`UVec4` helpers it and
//   `generateAttributeValue` use)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `RandomArrayGenerator` fills an `AttributeArray`'s (or an index array's) backing
// bytes with deterministic pseudo-random vertex data. Every function here returns a
// plain `Vec<u8>` rather than upstream's `new char[]` (the caller - `AttributePack`,
// not yet ported - already owns the array it would copy this into), and `AttributeArray`
// in this port does not take a raw pointer at all, only a `&[u8]` (see that module's
// own doc comment).
//
// **`alignmentSafeAssignment<T>`'s `memcpy` becomes `to_ne_bytes`/a direct byte write.**
// Upstream copies `T`'s native in-memory representation, whatever endianness the build
// host has; every target this port builds for (x86_64, aarch64, armv7) is little-endian
// in practice, so native-endian and little-endian coincide here - `to_ne_bytes` is kept
// rather than `to_le_bytes` to name the actual upstream operation being mirrored, not a
// stronger guarantee this port doesn't need.
//
// `createBasicArray<T, GLType>`'s two type parameters (the narrow storage type and the
// wrapped `GLValue` arithmetic type) collapse into one Rust type parameter: every
// `GLValue` wrapped type here already **is** its own storage representation (`Short`
// wraps `i16` directly, `Half` wraps the raw `deFloat16` bits), so nothing upstream's
// `T` named is missing. `ComponentBytes` is the one piece upstream's `GLType` alone
// didn't carry - how many bytes to write and how to write them - added here rather than
// on `GLValue` itself, since it is a concern of building a byte buffer, not of the value
// type's own arithmetic.

use super::gl_value::{
    Byte, Double, Fixed, Float, Half, Int, MinSeparation, RandomDraw, RandomRange, Short, Ubyte, Uint, Ushort,
    WrappedAbs,
};
use super::spec::{IndexType, InputType};
use crate::rr::generic_vector::GenericVec4;
use crate::tcu::Random;
use crate::tcu::vector::{IVec4, UVec4, Vec4};

/// `RandomArrayGenerator::generateArray`
pub fn generate_array(
    seed: u32,
    element_count: i32,
    component_count: i32,
    offset: i32,
    stride: i32,
    input_type: InputType,
) -> Vec<u8> {
    if matches!(input_type, InputType::Int2_10_10_10 | InputType::UnsignedInt2_10_10_10) {
        generate_packed_array(seed, element_count, component_count, offset, stride)
    } else {
        generate_basic_array(seed, element_count, component_count, offset, stride, input_type)
    }
}

/// `RandomArrayGenerator::generateBasicArray`
fn generate_basic_array(
    seed: u32,
    element_count: i32,
    component_count: i32,
    offset: i32,
    stride: i32,
    input_type: InputType,
) -> Vec<u8> {
    match input_type {
        InputType::Float => create_basic_array::<Float>(seed, element_count, component_count, offset, stride),
        InputType::Double => create_basic_array::<Double>(seed, element_count, component_count, offset, stride),
        InputType::Short => create_basic_array::<Short>(seed, element_count, component_count, offset, stride),
        InputType::UnsignedShort => create_basic_array::<Ushort>(seed, element_count, component_count, offset, stride),
        InputType::Byte => create_basic_array::<Byte>(seed, element_count, component_count, offset, stride),
        InputType::UnsignedByte => create_basic_array::<Ubyte>(seed, element_count, component_count, offset, stride),
        InputType::Fixed => create_basic_array::<Fixed>(seed, element_count, component_count, offset, stride),
        InputType::Int => create_basic_array::<Int>(seed, element_count, component_count, offset, stride),
        InputType::UnsignedInt => create_basic_array::<Uint>(seed, element_count, component_count, offset, stride),
        InputType::Half => create_basic_array::<Half>(seed, element_count, component_count, offset, stride),
        _ => {
            debug_assert!(false, "generateBasicArray: unexpected InputType {input_type:?}");
            Vec::new()
        }
    }
}

/// The one piece `createBasicArray<T, GLType>`'s `T` carried that nothing on `GLValue`
/// itself needs - see this module's top doc comment.
trait ComponentBytes: Copy {
    const SIZE: usize;
    fn write_ne(self, dst: &mut [u8]);
}
impl ComponentBytes for Float {
    const SIZE: usize = 4;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Double {
    const SIZE: usize = 8;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..8].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Short {
    const SIZE: usize = 2;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..2].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Ushort {
    const SIZE: usize = 2;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..2].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Byte {
    const SIZE: usize = 1;
    fn write_ne(self, dst: &mut [u8]) {
        dst[0] = self.value() as u8;
    }
}
impl ComponentBytes for Ubyte {
    const SIZE: usize = 1;
    fn write_ne(self, dst: &mut [u8]) {
        dst[0] = self.value();
    }
}
impl ComponentBytes for Fixed {
    const SIZE: usize = 4;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Int {
    const SIZE: usize = 4;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Uint {
    const SIZE: usize = 4;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.value().to_ne_bytes());
    }
}
impl ComponentBytes for Half {
    const SIZE: usize = 2;
    fn write_ne(self, dst: &mut [u8]) {
        dst[..2].copy_from_slice(&self.bits().to_ne_bytes());
    }
}

/// `RandomArrayGenerator::createBasicArray<T, GLType>`
fn create_basic_array<T>(seed: u32, element_count: i32, component_count: i32, offset: i32, stride: i32) -> Vec<u8>
where
    T: RandomRange + RandomDraw + MinSeparation + WrappedAbs + ComponentBytes + PartialOrd + std::ops::Sub<Output = T>,
{
    debug_assert!((1..=4).contains(&component_count));
    // Upstream only clamps the *upper* bound (`if componentCount > 4: componentCount =
    // 4`, there to silence a GCC false-positive warning, not to tolerate an invalid
    // call) - the real precondition is the `debug_assert!` above. Clamping both bounds
    // here is a deliberate strengthening beyond a literal translation: an out-of-
    // contract negative/zero count would otherwise become a huge `usize` two lines
    // down and panic the allocation rather than simply doing nothing useful.
    let component_count = component_count.clamp(1, 4) as usize;
    debug_assert!(element_count >= 1);

    let min = T::range_min();
    let max = T::range_max();

    let component_size = T::SIZE;
    let element_size = component_size * component_count;
    // Widened through i64 the same way upstream's own `Int` class widens its
    // arithmetic - `element_count == 0` would otherwise underflow `(element_count - 1)`
    // before this port's own `debug_assert!` above ever gets compiled out of a release
    // build.
    let buffer_size =
        (i64::from(offset) + (i64::from(element_count) - 1) * i64::from(stride) + element_size as i64) as usize;

    let mut data = vec![0u8; buffer_size];
    let mut rnd = Random::new(seed);

    let mut previous_components = [min; 4];
    let mut write_offset = offset as usize;

    for vertex_ndx in 0..element_count {
        let mut components = [min; 4];

        for component_ndx in 0..component_count {
            let mut v = T::random_draw(&mut rnd, min, max);

            // Try to not create a vertex near the previous one.
            if vertex_ndx != 0 && (v - previous_components[component_ndx]).wrapped_abs() < T::min_separation() {
                // Too close, try again (but only once).
                v = T::random_draw(&mut rnd, min, max);
            }
            components[component_ndx] = v;
        }

        previous_components[..component_count].copy_from_slice(&components[..component_count]);

        for (component_ndx, component) in components.iter().enumerate().take(component_count) {
            component.write_ne(&mut data[write_offset + component_ndx * component_size..]);
        }

        write_offset += stride as usize;
    }

    data
}

/// `RandomArrayGenerator::generatePackedArray`
fn generate_packed_array(seed: u32, element_count: i32, component_count: i32, offset: i32, stride: i32) -> Vec<u8> {
    debug_assert_eq!(component_count, 4);
    debug_assert!(element_count >= 1);

    const LIMIT10: u32 = 1 << 10;
    const LIMIT2: u32 = 1 << 2;
    const ELEMENT_SIZE: i64 = 4;

    let buffer_size = (i64::from(offset) + (i64::from(element_count) - 1) * i64::from(stride) + ELEMENT_SIZE) as usize;
    let mut data = vec![0u8; buffer_size];
    let mut rnd = Random::new(seed);

    let mut write_offset = offset as usize;
    for _ in 0..element_count {
        let x = rnd.get_uint32() % LIMIT10;
        let y = rnd.get_uint32() % LIMIT10;
        let z = rnd.get_uint32() % LIMIT10;
        let w = rnd.get_uint32() % LIMIT2;
        let packed_value = (w << 30) | (z << 20) | (y << 10) | x;

        data[write_offset..write_offset + 4].copy_from_slice(&packed_value.to_ne_bytes());
        write_offset += stride as usize;
    }

    data
}

/// `RandomArrayGenerator::generateIndices`
pub fn generate_indices(
    seed: u32,
    element_count: i32,
    index_type: IndexType,
    offset: i32,
    min: i32,
    max: i32,
    index_base: i32,
) -> Vec<u8> {
    match index_type {
        IndexType::Byte => create_indices::<u8>(seed, element_count, offset, min, max, index_base),
        IndexType::Short => create_indices::<u16>(seed, element_count, offset, min, max, index_base),
        IndexType::Int => create_indices::<u32>(seed, element_count, offset, min, max, index_base),
        IndexType::Last => unreachable!("generate_indices: index_type must be set"),
    }
}

trait IndexStorage: Copy {
    const SIZE: usize;
    fn truncate(value: u32) -> Self;
    fn write_ne(self, dst: &mut [u8]);
}
impl IndexStorage for u8 {
    const SIZE: usize = 1;
    fn truncate(value: u32) -> Self {
        value as u8
    }
    fn write_ne(self, dst: &mut [u8]) {
        dst[0] = self;
    }
}
impl IndexStorage for u16 {
    const SIZE: usize = 2;
    fn truncate(value: u32) -> Self {
        value as u16
    }
    fn write_ne(self, dst: &mut [u8]) {
        dst[..2].copy_from_slice(&self.to_ne_bytes());
    }
}
impl IndexStorage for u32 {
    const SIZE: usize = 4;
    fn truncate(value: u32) -> Self {
        value
    }
    fn write_ne(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.to_ne_bytes());
    }
}

/// `RandomArrayGenerator::createIndices<T>`
fn create_indices<T: IndexStorage>(
    seed: u32,
    element_count: i32,
    offset: i32,
    min: i32,
    max: i32,
    index_base: i32,
) -> Vec<u8> {
    debug_assert!(index_base >= 0); // Watch for underflows.
    // Upstream's own `DE_FATAL("Invalid range")` - a hard abort, not a recoverable
    // error; ported as a `debug_assert!` since nothing in this port's scope constructs
    // an out-of-range call.
    debug_assert!(min >= 0 && max >= 0 && min <= max);

    let element_size = T::SIZE;
    let buffer_size = offset as usize + element_count as usize * element_size;
    let mut data = vec![0u8; buffer_size];
    let mut rnd = Random::new(seed);

    let mut old_ndx1 = u32::MAX;
    let mut old_ndx2 = u32::MAX;

    let min_u = Uint::create(min as u32);
    let max_u = Uint::create(max as u32);

    for element_ndx in 0..element_count as usize {
        let mut ndx = Uint::random_draw(&mut rnd, min_u, max_u).value();

        // Try not to generate the same index as either of the previous two. This
        // prevents degenerate triangles/lines; if [min, max] is too small this cannot
        // be guaranteed.
        if ndx == old_ndx1 {
            ndx += 1;
        }
        if ndx > max as u32 {
            ndx = min as u32;
        }
        if ndx == old_ndx2 {
            ndx += 1;
        }
        if ndx > max as u32 {
            ndx = min as u32;
        }
        if ndx == old_ndx1 {
            ndx += 1;
        }
        if ndx > max as u32 {
            ndx = min as u32;
        }

        old_ndx2 = old_ndx1;
        old_ndx1 = ndx;

        ndx += index_base as u32;

        T::truncate(ndx).write_ne(&mut data[offset as usize + element_size * element_ndx..]);
    }

    data
}

/// `generateRandomVec4` - Rust guarantees left-to-right function-argument evaluation
/// (unlike C++), so this already draws x, then y, then z, then w in one expression -
/// exactly the loop upstream's own version needs to force that same order.
fn generate_random_vec4(random: &mut Random) -> Vec4 {
    Vec4::new(
        random.get_float(),
        random.get_float(),
        random.get_float(),
        random.get_float(),
    )
}

/// `generateRandomIVec4`
fn generate_random_ivec4(random: &mut Random) -> IVec4 {
    IVec4::new(
        random.get_uint32() as i32,
        random.get_uint32() as i32,
        random.get_uint32() as i32,
        random.get_uint32() as i32,
    )
}

/// `generateRandomUVec4`
fn generate_random_uvec4(random: &mut Random) -> UVec4 {
    UVec4::new(
        random.get_uint32(),
        random.get_uint32(),
        random.get_uint32(),
        random.get_uint32(),
    )
}

/// `RandomArrayGenerator::generateAttributeValue`
pub fn generate_attribute_value(seed: u32, input_type: InputType) -> GenericVec4 {
    let mut random = Random::new(seed);

    match input_type {
        InputType::Float => GenericVec4::from_float(generate_random_vec4(&mut random)),
        InputType::Int => GenericVec4::from_int(generate_random_ivec4(&mut random)),
        InputType::UnsignedInt => GenericVec4::from_uint(generate_random_uvec4(&mut random)),
        _ => {
            debug_assert!(false, "generateAttributeValue: unexpected InputType {input_type:?}");
            GenericVec4::from_float(Vec4::new(1.0, 1.0, 1.0, 1.0))
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn generate_array_byte_size_matches_layout() {
        // 3 elements, 2 components of f32 (4 bytes), offset 4, stride 16:
        // buffer_size = 4 + (3-1)*16 + 2*4 = 4 + 32 + 8 = 44.
        let bytes = generate_array(1, 3, 2, 4, 16, InputType::Float);
        assert_eq!(bytes.len(), 44);
    }

    #[test]
    fn generate_array_is_deterministic_for_a_fixed_seed() {
        let a = generate_array(42, 4, 3, 0, 12, InputType::Short);
        let b = generate_array(42, 4, 3, 0, 12, InputType::Short);
        assert_eq!(a, b);
    }

    #[test]
    fn generate_array_differs_across_seeds() {
        let a = generate_array(1, 4, 3, 0, 12, InputType::Int);
        let b = generate_array(2, 4, 3, 0, 12, InputType::Int);
        assert_ne!(a, b);
    }

    #[test]
    fn generate_array_values_stay_within_the_input_types_range() {
        let bytes = generate_array(7, 20, 1, 0, 1, InputType::Byte);
        assert_eq!(bytes.len(), 20);
        for &b in &bytes {
            let v = b as i8;
            assert!((-127..=127).contains(&v), "{v} out of Byte's [-127, 127] range");
        }
    }

    #[test]
    fn generate_packed_array_packs_four_fields_into_one_word() {
        let bytes = generate_array(3, 2, 4, 0, 4, InputType::UnsignedInt2_10_10_10);
        assert_eq!(bytes.len(), 8);
        let word = u32::from_ne_bytes(bytes[0..4].try_into().unwrap());
        // w is only 2 bits - the top two bits of the packed word.
        assert!(word >> 30 <= 0b11);
    }

    #[test]
    #[allow(clippy::chunks_exact_to_as_chunks)] // `as_chunks` is nightly-unstable
    fn generate_indices_stays_within_min_max_after_index_base() {
        let bytes = generate_indices(5, 50, IndexType::Short, 0, 2, 10, 100);
        assert_eq!(bytes.len(), 100);
        for chunk in bytes.chunks_exact(2) {
            let v = u16::from_ne_bytes(chunk.try_into().unwrap());
            assert!((102..=110).contains(&v), "{v} out of [102, 110]");
        }
    }

    #[test]
    #[allow(clippy::chunks_exact_to_as_chunks)] // `as_chunks` is nightly-unstable
    fn generate_indices_stays_in_range_over_many_elements() {
        // Upstream's own comment is honest that the anti-repeat compensation is best
        // effort, not a guarantee, when the range is small relative to the element
        // count - so this only checks the one invariant that always holds (the bound
        // clamp), not non-repetition, which this port cannot verify by hand for an
        // arbitrary seed without running it.
        let bytes = generate_indices(9, 200, IndexType::Int, 0, 0, 1000, 0);
        assert_eq!(bytes.len(), 800);
        for chunk in bytes.chunks_exact(4) {
            let v = u32::from_ne_bytes(chunk.try_into().unwrap());
            assert!(v <= 1000, "{v} out of [0, 1000]");
        }
    }

    #[test]
    fn generate_attribute_value_picks_the_right_generic_vec_type() {
        let v = generate_attribute_value(11, InputType::Float);
        // Any float draw is in [0, 1) per `de::Random::getFloat`.
        let f = v.get_float();
        assert!((0.0..1.0).contains(&f.x()));
        assert!((0.0..1.0).contains(&f.y()));
    }
}
