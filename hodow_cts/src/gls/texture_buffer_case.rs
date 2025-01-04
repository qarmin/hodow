// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsTextureBufferCase.{hpp,cpp}
//   framework/opengl/gluTexture.{hpp,cpp}  (glu::TextureBuffer, the parts used here)
//   framework/opengl/gluTextureUtil.cpp  (getTextureBufferEffectiveRefTexture)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `run_case` is `TextureBufferCase::
// iterate`/`runTests` in full: `preRender`/`modify`/`postRender` are each an
// `Option`, matching upstream's "0 means skip this step" convention. `render_case` is a
// thin wrapper over it for the `render` group's `preRender`/`modify`-always-none shape.
// Reference rendering goes through `rr::triangle_rasterizer`, a purpose-built
// rasteriser rather than a port of upstream's own generic one - see that module's doc
// comment for why.
//
// A genuine de-risking finding, worth keeping in mind when reading `apply_modify`:
// upstream's `rng` draw count differs per modify function (`modifyBufferData`'s own
// `genRandomCoords(rng, ...)` call takes `rng` *by value*, so it draws nothing the
// caller sees; the other three draw two real values each). Matching that exact draw
// count is not required for correctness here - nothing compares this port's `rng`
// stream against upstream's own, only this port's GL-side buffer and its host-side
// mirror need to agree with each other, and both are always derived from the same
// `Random` binding threaded through `run_case`.

use crate::glu::objects::BufferMemMap;
use crate::glu::{ApiCase, Buffer, Context, GlslVersion, ProgramSources, ShaderProgram, Texture, VertexArray};
use crate::glw;
use crate::rr::triangle_rasterizer::{self, Vertex};
use crate::tcu::Surface;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{TextureLevel, clear};
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec4;

const MAX_VIEWPORT_WIDTH: i32 = 256;
const MAX_VIEWPORT_HEIGHT: i32 = 256;
const MIN_VIEWPORT_WIDTH: i32 = 64;
const MIN_VIEWPORT_HEIGHT: i32 = 64;
const TRIANGLE_COUNT: u32 = 8;
const CLEAR_COLOR: Vec4 = Vec4::new(0.25, 0.5, 0.75, 1.0);

/// `TextureBufferCaseUtil::RenderBits`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct RenderBits {
    pub vertex_array: bool,
    pub index_array: bool,
    pub vertex_texture: bool,
    pub fragment_texture: bool,
}

impl RenderBits {
    pub const fn new(vertex_array: bool, index_array: bool, vertex_texture: bool, fragment_texture: bool) -> Self {
        Self {
            vertex_array,
            index_array,
            vertex_texture,
            fragment_texture,
        }
    }

    /// `toTestName(RenderBits)` - the bit order upstream's own `bitInfos` table joins
    /// in, which is also the leaf test-group name.
    pub fn test_name(self) -> String {
        let mut parts = Vec::new();
        if self.vertex_array {
            parts.push("as_vertex_array");
        }
        if self.index_array {
            parts.push("as_index_array");
        }
        if self.vertex_texture {
            parts.push("as_vertex_texture");
        }
        if self.fragment_texture {
            parts.push("as_fragment_texture");
        }
        parts.join("_")
    }
}

/// `TextureBufferCaseUtil::ModifyBits`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct ModifyBits {
    pub buffer_data: bool,
    pub buffer_sub_data: bool,
    pub map_write: bool,
    pub map_read_write: bool,
}

impl ModifyBits {
    pub const fn new(buffer_data: bool, buffer_sub_data: bool, map_write: bool, map_read_write: bool) -> Self {
        Self {
            buffer_data,
            buffer_sub_data,
            map_write,
            map_read_write,
        }
    }

    /// `toTestName(ModifyBits)` - every case here sets exactly one bit, so this never
    /// has to join several names the way `RenderBits::test_name` does.
    pub fn test_name(self) -> &'static str {
        if self.buffer_data {
            "bufferdata"
        } else if self.buffer_sub_data {
            "buffersubdata"
        } else if self.map_write {
            "mapbuffer_write"
        } else {
            debug_assert!(
                self.map_read_write,
                "ModifyBits::test_name called on an all-false value"
            );
            "mapbuffer_readwrite"
        }
    }
}

/// `checkSupport` / `TextureBufferCase::init`'s support check - upstream also accepts a
/// desktop `core(4, 5)` context; this port only ever creates ES contexts, so that
/// branch cannot be reached and is not written out.
fn check_support(case: &mut ApiCase<'_>) -> bool {
    let context: &Context = case.context();
    if context.context_type().supports(3, 2) || context.context_info.is_extension_supported("GL_EXT_texture_buffer") {
        return true;
    }
    case.not_supported("GL_EXT_texture_buffer is not supported");
    false
}

/// `extend2BitsToByte`
const fn extend_2_bits_to_byte(bits: u8) -> u8 {
    bits | (bits << 2) | (bits << 4) | (bits << 6)
}

/// `genRandomCoords` - deterministic, buffer-shaped "random" content: every byte is a
/// 2-bit value extended to fill a byte (so every decoded UNORM8 coordinate lands on one
/// of exactly four grid points), then two overrides land specific bytes at specific
/// absolute positions regardless of the random fill - see the module's own vertex/index
/// documentation above for what those bytes end up meaning once this is bound as a
/// vertex or index source.
fn gen_random_coords(mut rng: Random, offset: usize, size: usize) -> Vec<u8> {
    let mut coords = vec![0u8; size];
    for c in &mut coords {
        let x_bits = (rng.get_uint32() & 0x3) as u8;
        *c = extend_2_bits_to_byte(x_bits);
    }

    // Fill indices with nice quad.
    let corner_markers = [
        extend_2_bits_to_byte(0),
        extend_2_bits_to_byte(1),
        extend_2_bits_to_byte(2),
        extend_2_bits_to_byte(3),
    ];
    for (i, &marker) in corner_markers.iter().enumerate() {
        let pos_x = usize::from(marker) * 2;
        let pos_y = pos_x + 1;
        if pos_x >= offset && pos_x < offset + size {
            coords[pos_x - offset] = if i % 2 == 0 {
                extend_2_bits_to_byte(0)
            } else {
                extend_2_bits_to_byte(3)
            };
        }
        if pos_y >= offset && pos_y < offset + size {
            coords[pos_y - offset] = if i / 2 == 1 {
                extend_2_bits_to_byte(3)
            } else {
                extend_2_bits_to_byte(0)
            };
        }
    }

    // Fill beginning of buffer.
    let begin: [u8; 12] = [
        extend_2_bits_to_byte(0),
        extend_2_bits_to_byte(3),
        extend_2_bits_to_byte(1),
        extend_2_bits_to_byte(1),
        extend_2_bits_to_byte(2),
        extend_2_bits_to_byte(0),
        extend_2_bits_to_byte(0),
        extend_2_bits_to_byte(2),
        extend_2_bits_to_byte(1),
        extend_2_bits_to_byte(1),
        extend_2_bits_to_byte(3),
        extend_2_bits_to_byte(0),
    ];
    for (i, &v) in begin.iter().enumerate() {
        if i >= offset && i < offset + size {
            coords[i - offset] = v;
        }
    }

    coords
}

/// The `runTests`-local patch applied on top of `genRandomCoords`'s own output, over
/// the *texture range*'s `offset`/`size` (0 meaning "no range restriction" here, which
/// upstream's own `val < offset + size` makes correctly inert for `size == 0`).
fn patch_nice_quad_markers(buffer_data: &mut [u8], offset: usize, size: usize) {
    for i in 0u8..4 {
        let val = usize::from(extend_2_bits_to_byte(i));
        if val >= offset && val < offset + size {
            buffer_data[val * 2] = if i / 2 == 0 {
                extend_2_bits_to_byte(2)
            } else {
                extend_2_bits_to_byte(1)
            };
            buffer_data[val * 2 + 1] = if i % 2 == 0 {
                extend_2_bits_to_byte(2)
            } else {
                extend_2_bits_to_byte(1)
            };
        }
    }
}

/// `glu::getTextureBufferEffectiveRefTexture` over a `GL_RGBA8` buffer: how many texels
/// starting at `offset` are visible to a `samplerBuffer`, and how to read one.
struct EffectiveTexture<'a> {
    data: &'a [u8],
    offset: usize,
    width: i32,
}

impl EffectiveTexture<'_> {
    fn new<'a>(
        buffer_data: &'a [u8],
        offset: usize,
        size: usize,
        max_texture_buffer_size: i32,
    ) -> EffectiveTexture<'a> {
        let full_len_bytes = if size != 0 { size } else { buffer_data.len() };
        let full_width = (full_len_bytes / 4) as i32;
        EffectiveTexture {
            data: buffer_data,
            offset,
            width: full_width.min(max_texture_buffer_size).max(1),
        }
    }

    /// `texelFetch(sampler, clamp(index, 0, textureSize - 1))`
    fn fetch(&self, index: i64) -> Vec4 {
        let clamped = index.clamp(0, i64::from(self.width) - 1) as usize;
        let byte_off = self.offset + clamped * 4;
        let bytes = &self.data[byte_off..byte_off + 4];
        Vec4::new(
            f32::from(bytes[0]) / 255.0,
            f32::from(bytes[1]) / 255.0,
            f32::from(bytes[2]) / 255.0,
            f32::from(bytes[3]) / 255.0,
        )
    }
}

/// The position source's own byte pair for vertex index `index` - both `buffer_data`
/// (bound whole, regardless of the texture's own range) and the synthetic fallback
/// coordinate buffer are read the same way.
fn position_at(source: &[u8], index: u32) -> [f32; 2] {
    let i = index as usize * 2;
    [f32::from(source[i]) / 255.0, f32::from(source[i + 1]) / 255.0]
}

/// `CoordVertexShader`/`TextureVertexShader::shadeVertices` - the vertex's own output
/// varying, as a function of its `i_coord` attribute alone.
fn vertex_varying(render: RenderBits, coord: [f32; 2], vtx_tex: Option<&EffectiveTexture<'_>>) -> Vec4 {
    if render.vertex_texture {
        let tex = vtx_tex.expect("vertex_texture set implies a bound vertex sampler");
        let ix = (coord[0] * 4.0).round() as i64 + 4;
        let iy = (coord[1] * 4.0).round() as i64 + 4;
        tex.fetch(ix * iy)
    } else {
        Vec4::splat(1.0)
    }
}

/// `CoordFragmentShader`/`TextureFragmentShader::shadeFragments`
fn fragment_color(
    render: RenderBits,
    vtx_color: Vec4,
    px: i32,
    py: i32,
    frag_tex: Option<&EffectiveTexture<'_>>,
) -> Vec4 {
    let color = if render.fragment_texture {
        let tex = frag_tex.expect("fragment_texture set implies a bound fragment sampler");
        let tex_color = tex.fetch(i64::from(px) * i64::from(py));
        (vtx_color + tex_color) * 0.5
    } else {
        vtx_color
    };
    Vec4::new(color.x() * color.w(), color.y() * color.w(), color.z() * color.w(), 1.0)
}

/// `generateVertexShaderTemplate` + `specializeShader`, ES-only (`HIGHP` is always
/// `"highp"` and the texture-buffer extension line is always emitted, matching
/// upstream's own ternary that only special-cases desktop GL 3.3).
fn vertex_shader_source(render: RenderBits, version: GlslVersion) -> String {
    let ext = if render.vertex_texture {
        "#extension GL_EXT_texture_buffer : enable\n"
    } else {
        ""
    };
    let sampler_decl = if render.vertex_texture {
        "uniform highp samplerBuffer u_vtxSampler;\n"
    } else {
        ""
    };
    let compute = if render.vertex_texture {
        "\tv_color = texelFetch(u_vtxSampler, clamp((int(round(i_coord.x * 4.0)) + 4) * (int(round(i_coord.y * 4.0)) + 4), 0, textureSize(u_vtxSampler)-1));\n"
    } else {
        "\tv_color = vec4(1.0);\n"
    };
    format!(
        "{}\n{ext}in layout(location = 0) highp vec2 i_coord;\nout highp vec4 v_color;\n{sampler_decl}\nvoid main (void)\n{{\n{compute}\tgl_Position = vec4(2.0 * (i_coord - vec2(0.5)), 0.0, 1.0);\n}}\n",
        version.declaration()
    )
}

/// `generateFragmentShaderTemplate` + `specializeShader`
fn fragment_shader_source(render: RenderBits, version: GlslVersion) -> String {
    let ext = if render.fragment_texture {
        "#extension GL_EXT_texture_buffer : enable\n"
    } else {
        ""
    };
    let sampler_decl = if render.fragment_texture {
        "uniform highp samplerBuffer u_fragSampler;\n"
    } else {
        ""
    };
    let compute = if render.fragment_texture {
        "\thighp vec4 color = 0.5 * (v_color + texelFetch(u_fragSampler, clamp(int(gl_FragCoord.x) * int(gl_FragCoord.y), 0, textureSize(u_fragSampler)-1)));\n"
    } else {
        "\thighp vec4 color = v_color;\n"
    };
    format!(
        "{}\n{ext}out layout(location = 0) highp vec4 dEQP_FragColor;\nin highp vec4 v_color;\n{sampler_decl}\nvoid main (void)\n{{\n{compute}\tdEQP_FragColor = vec4(color.xyz * color.w, 1.0);\n}}\n",
        version.declaration()
    )
}

/// `genRandomCoords(rng, coords, 0, 256 * 2)` - the synthetic position source used
/// whenever `RENDERBITS_AS_VERTEX_ARRAY` is not set, deterministic from `coord_seed`
/// alone (both `renderGL` and `renderReference` reconstruct it independently this way,
/// so there is nothing to share between the GL-side draw and the host reference beyond
/// the seed).
fn synthetic_coord_buffer(coord_seed: u32) -> Vec<u8> {
    gen_random_coords(Random::new(coord_seed), 0, 256 * 2)
}

/// `renderGL`
fn render_gl(
    context: &Context,
    render: RenderBits,
    coord_seed: u32,
    program: &ShaderProgram<'_>,
    gl_buffer: u32,
    gl_texture: u32,
) {
    let gl = context.gl();
    let vao = VertexArray::new(gl);
    let coord_buffer = Buffer::new(gl);

    // SAFETY: every name here is either this function's own or the caller's live
    // texture buffer/texture; the draw calls that follow match how each buffer was
    // just bound.
    unsafe {
        gl.use_program(program.program());
        gl.bind_vertex_array(vao.get());
        gl.enable_vertex_attrib_array(0);

        if render.vertex_array {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, gl_buffer);
            gl.vertex_attrib_pointer(0, 2, glw::GL_UNSIGNED_BYTE, glw::TRUE, 0, std::ptr::null());
        } else {
            let coords = synthetic_coord_buffer(coord_seed);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, coord_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                coords.len() as isize,
                coords.as_ptr().cast(),
                glw::GL_STREAM_DRAW,
            );
            gl.vertex_attrib_pointer(0, 2, glw::GL_UNSIGNED_BYTE, glw::TRUE, 0, std::ptr::null());
        }

        if render.vertex_texture {
            let location = gl.get_uniform_location(program.program(), c"u_vtxSampler".as_ptr());
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, gl_texture);
            gl.uniform_1i(location, 0);
        }
        if render.fragment_texture {
            let location = gl.get_uniform_location(program.program(), c"u_fragSampler".as_ptr());
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, gl_texture);
            gl.uniform_1i(location, 1);
            gl.active_texture(glw::GL_TEXTURE0);
        }

        if render.index_array {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, gl_buffer);
            gl.draw_elements(
                glw::GL_TRIANGLES,
                (TRIANGLE_COUNT * 3) as i32,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        } else {
            gl.draw_arrays(glw::GL_TRIANGLES, 0, (TRIANGLE_COUNT * 3) as i32);
        }

        if render.fragment_texture {
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0);
        }
        if render.vertex_texture {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0);
        }

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.disable_vertex_attrib_array(0);
        gl.bind_vertex_array(0);
        gl.use_program(0);
    }
}

/// `renderReference`
fn render_reference(
    render: RenderBits,
    coord_seed: u32,
    buffer_data: &[u8],
    vtx_tex: Option<&EffectiveTexture<'_>>,
    frag_tex: Option<&EffectiveTexture<'_>>,
    target: &mut TextureLevel,
) {
    let width = target.size()[0] as i32;
    let height = target.size()[1] as i32;

    let position_source: Vec<u8>;
    let positions: &[u8] = if render.vertex_array {
        buffer_data
    } else {
        position_source = synthetic_coord_buffer(coord_seed);
        &position_source
    };

    // When `RENDERBITS_AS_INDEX_ARRAY` is set, an index is a raw `GL_UNSIGNED_BYTE`
    // value read straight out of the bound buffer - i.e. any value 0..=255, not just
    // the 24 the draw call actually uses as *indices* - so the position array a vertex
    // index addresses has to cover the whole byte range `vertexAttribPointer` could be
    // asked to read, matching the >= 512-byte buffer/coord-buffer this always has.
    let num_vertices = TRIANGLE_COUNT * 3;
    let mut vertices = Vec::with_capacity(256);
    for i in 0..256u32 {
        let coord = position_at(positions, i);
        let varying = vertex_varying(render, coord, vtx_tex);
        let x = 2.0 * (coord[0] - 0.5);
        let y = 2.0 * (coord[1] - 0.5);
        let screen_x = (x * 0.5 + 0.5) * width as f32;
        let screen_y = (y * 0.5 + 0.5) * height as f32;
        vertices.push(Vertex::new(screen_x, screen_y, varying));
    }

    let indices: Vec<u32> = if render.index_array {
        buffer_data[..num_vertices as usize]
            .iter()
            .map(|&b| u32::from(b))
            .collect()
    } else {
        (0..num_vertices).collect()
    };

    let mut access = target.get_access();
    triangle_rasterizer::rasterize_triangle_list(width, height, &vertices, &indices, &mut |x, y, varying| {
        let color = fragment_color(render, varying, x, y, frag_tex);
        access.set_pixel(color.m_data, x as u32, y as u32, 0);
    });
}

/// The size/offset draw shared by `modifyBufferSubData`/`modifyMapWrite`/
/// `modifyMapReadWrite`: a size that is 70-100% of the texture's own range (or the
/// whole buffer, if the range is unrestricted), at a random offset within what is left
/// after that size and the range's own starting offset. Draws `rng.getFloat()` then
/// `rng.getUint32()`, in that order, matching upstream's own two statements.
fn modify_range_params(rng: &mut Random, buffer_len: usize, offset: usize, size: usize) -> (usize, usize) {
    const MIN_SIZE: usize = 4 * 16;
    let size_basis = if size != 0 { size } else { buffer_len };
    let frac = 0.7 + 0.3 * rng.get_float();
    let computed_size = MIN_SIZE.max((size_basis as f32 * frac) as usize);
    let min_offset = offset;
    let computed_offset = min_offset + (rng.get_uint32() as usize % (buffer_len - (computed_size + min_offset)));
    (computed_offset, computed_size)
}

/// `modifyBufferData` - replaces the whole buffer's content (same length, new bytes)
/// via a fresh `glBufferData()`, mirroring the same bytes into the host-side copy.
fn modify_buffer_data(
    gl: &glw::Functions,
    rng: &mut Random,
    gl_buffer: u32,
    buffer_data: &mut [u8],
) -> Result<(), String> {
    let new_data = gen_random_coords(*rng, 0, buffer_data.len());
    buffer_data.copy_from_slice(&new_data);

    // SAFETY: `gl_buffer` is the caller's own persistent texture-buffer name.
    unsafe {
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, gl_buffer);
        gl.buffer_data(
            glw::GL_TEXTURE_BUFFER,
            buffer_data.len() as isize,
            buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0);
    }
    crate::glu::expect_no_error(gl, "Failed to update data with glBufferData()").map_err(|e| e.to_string())
}

/// `modifyBufferSubData`
fn modify_buffer_sub_data(
    gl: &glw::Functions,
    rng: &mut Random,
    gl_buffer: u32,
    buffer_data: &mut [u8],
    offset: usize,
    size: usize,
) -> Result<(), String> {
    let (computed_offset, computed_size) = modify_range_params(rng, buffer_data.len(), offset, size);
    let data = gen_random_coords(*rng, computed_offset, computed_size);

    // SAFETY: `computed_offset`/`data.len()` were derived to stay inside the buffer's
    // own allocation (see `modify_range_params`).
    unsafe {
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, gl_buffer);
        gl.buffer_sub_data(
            glw::GL_TEXTURE_BUFFER,
            computed_offset as isize,
            data.len() as isize,
            data.as_ptr().cast(),
        );
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0);
    }
    crate::glu::expect_no_error(gl, "Failed to update data with glBufferSubData()").map_err(|e| e.to_string())?;

    buffer_data[computed_offset..computed_offset + data.len()].copy_from_slice(&data);
    Ok(())
}

/// `modifyMapWrite`
fn modify_map_write(
    gl: &glw::Functions,
    rng: &mut Random,
    gl_buffer: u32,
    buffer_data: &mut [u8],
    offset: usize,
    size: usize,
) -> Result<(), String> {
    let (computed_offset, computed_size) = modify_range_params(rng, buffer_data.len(), offset, size);
    let data = gen_random_coords(*rng, computed_offset, computed_size);

    // SAFETY: `gl_buffer` is the caller's own persistent texture-buffer name.
    unsafe { gl.bind_buffer(glw::GL_TEXTURE_BUFFER, gl_buffer) };
    let map_result = BufferMemMap::new(
        gl,
        glw::GL_TEXTURE_BUFFER,
        computed_offset as isize,
        computed_size as isize,
        glw::GL_MAP_WRITE_BIT,
    );
    let outcome = match map_result {
        Some(map) => {
            // SAFETY: the mapping covers exactly `data.len()` writable bytes.
            unsafe { map.write_strided::<u8>(0, 1, &data) };
            Ok(())
        }
        None => Err("glMapBufferRange() returned null".to_string()),
    };
    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0) };
    outcome?;
    crate::glu::expect_no_error(gl, "Failed to update data with glMapBufferRange()").map_err(|e| e.to_string())?;

    buffer_data[computed_offset..computed_offset + data.len()].copy_from_slice(&data);
    Ok(())
}

/// `modifyMapReadWrite` - also checks the bytes the driver hands back through the
/// read-write mapping against this port's own host mirror before overwriting them,
/// same as upstream's `resultCollector.fail("Invalid data in mapped buffer")`.
fn modify_map_read_write(
    case: &mut ApiCase<'_>,
    rng: &mut Random,
    gl_buffer: u32,
    buffer_data: &mut [u8],
    offset: usize,
    size: usize,
) -> Result<(), String> {
    let (computed_offset, computed_size) = modify_range_params(rng, buffer_data.len(), offset, size);
    let data = gen_random_coords(*rng, computed_offset, computed_size);
    let ref_slice = buffer_data[computed_offset..computed_offset + computed_size].to_vec();

    let gl = case.gl();
    // SAFETY: `gl_buffer` is the caller's own persistent texture-buffer name.
    unsafe { gl.bind_buffer(glw::GL_TEXTURE_BUFFER, gl_buffer) };
    let map_result = BufferMemMap::new(
        gl,
        glw::GL_TEXTURE_BUFFER,
        computed_offset as isize,
        computed_size as isize,
        glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
    );
    let outcome = match map_result {
        Some(map) => {
            // SAFETY: the mapping covers exactly `computed_size` readable+writable bytes.
            let mapped: Vec<u8> = unsafe { map.read_strided(0, 1, computed_size) };
            let invalid = mapped.iter().zip(&ref_slice).filter(|(a, b)| a != b).count();
            if invalid > 0 {
                case.fail(format!("{invalid} invalid bytes in mapped buffer"), "Fail");
            }
            // SAFETY: as above.
            unsafe { map.write_strided::<u8>(0, 1, &data) };
            Ok(())
        }
        None => Err("glMapBufferRange() returned null".to_string()),
    };
    let gl = case.gl();
    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0) };
    outcome?;
    crate::glu::expect_no_error(gl, "Failed to update data with glMapBufferRange()").map_err(|e| e.to_string())?;

    buffer_data[computed_offset..computed_offset + computed_size].copy_from_slice(&data);
    Ok(())
}

/// `modify` - dispatches whichever bits are set. Every case registered in
/// `texture_buffer_tests.rs` sets exactly one, but the dispatch stays bit-by-bit to
/// match upstream's own shape.
fn apply_modify(
    case: &mut ApiCase<'_>,
    modify: ModifyBits,
    rng: &mut Random,
    gl_buffer: u32,
    buffer_data: &mut [u8],
    offset: usize,
    size: usize,
) -> Result<(), String> {
    if modify.buffer_data {
        modify_buffer_data(case.gl(), rng, gl_buffer, buffer_data)?;
    }
    if modify.buffer_sub_data {
        modify_buffer_sub_data(case.gl(), rng, gl_buffer, buffer_data, offset, size)?;
    }
    if modify.map_write {
        modify_map_write(case.gl(), rng, gl_buffer, buffer_data, offset, size)?;
    }
    if modify.map_read_write {
        modify_map_read_write(case, rng, gl_buffer, buffer_data, offset, size)?;
    }
    Ok(())
}

/// `render` (the free function, not `render_case`) - one GL-side draw plus its
/// host-side reference, both built from the same freshly-drawn `coordSeed` and the
/// *current* `buffer_data` (which `modify` may have changed since the last call).
#[expect(
    clippy::too_many_arguments,
    reason = "mirrors upstream's own render()/renderReference() parameter list"
)]
fn do_render(
    context: &Context,
    render: RenderBits,
    rng: &mut Random,
    gl_buffer: u32,
    gl_texture: u32,
    max_texture_buffer_size: i32,
    buffer_data: &[u8],
    offset: usize,
    size: usize,
    target: &mut TextureLevel,
) -> Result<(), String> {
    let coord_seed = rng.get_uint32();

    let version = context.context_type().glsl_version();
    let sources = ProgramSources::vtx_frag(
        vertex_shader_source(render, version),
        fragment_shader_source(render, version),
    );
    let program = ShaderProgram::new(context.gl(), &sources);
    if !program.is_ok() {
        return Err("Compile failed".to_string());
    }

    render_gl(context, render, coord_seed, &program, gl_buffer, gl_texture);
    crate::glu::expect_no_error(context.gl(), "Rendering failed").map_err(|e| e.to_string())?;

    let vtx_tex = render
        .vertex_texture
        .then(|| EffectiveTexture::new(buffer_data, offset, size, max_texture_buffer_size));
    let frag_tex = render
        .fragment_texture
        .then(|| EffectiveTexture::new(buffer_data, offset, size, max_texture_buffer_size));
    render_reference(
        render,
        coord_seed,
        buffer_data,
        vtx_tex.as_ref(),
        frag_tex.as_ref(),
        target,
    );
    Ok(())
}

/// `verifyScreen`
fn verify_screen(case: &mut ApiCase<'_>, reference: &TextureLevel) {
    let width = reference.size()[0] as i32;
    let height = reference.size()[1] as i32;
    let mut screen = Surface::new(width, height);
    if let Err(e) = crate::glu::read_pixels(&case.context().render_context, 0, 0, &mut screen.get_access()) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    match fuzzy_compare_ok(&reference.get_const_access(), &screen.get_const_access(), 0.05) {
        Some(true) => {}
        Some(false) => case.fail("Image comparison failed".to_string(), "Fail"),
        None => case.fail("fuzzyCompare on mismatched surfaces".to_string(), "Fail"),
    }
}

/// `TextureBufferCase::iterate` / `runTests`, in full: `pre_render`/`modify`/
/// `post_render` are each `None` wherever upstream passes the corresponding `0`
/// (`RENDERBITS_NONE`/`MODIFYBITS_NONE`).
#[expect(
    clippy::too_many_arguments,
    reason = "mirrors upstream's own TextureBufferCase constructor/runTests parameter list"
)]
pub fn run_case(
    case: &mut ApiCase<'_>,
    test_name: &str,
    buffer_size: usize,
    offset_units: usize,
    size: usize,
    pre_render: Option<RenderBits>,
    modify: Option<ModifyBits>,
    post_render: Option<RenderBits>,
) {
    if !check_support(case) {
        return;
    }

    let gl = case.gl();

    let mut max_texture_buffer_size = 0i32;
    // SAFETY: a single-integer query on a current context.
    unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_BUFFER_SIZE, &mut max_texture_buffer_size) };
    if max_texture_buffer_size <= 0 {
        case.not_supported("GL_MAX_TEXTURE_BUFFER_SIZE > 0 required");
        return;
    }

    let offset = if offset_units != 0 {
        let mut alignment = 0i32;
        // SAFETY: as above.
        unsafe { gl.get_integerv(glw::GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT, &mut alignment) };
        offset_units * alignment.max(0) as usize
    } else {
        0
    };

    let render_target = case.context().render_target();
    let width = render_target.width.min(MAX_VIEWPORT_WIDTH);
    let height = render_target.height.min(MAX_VIEWPORT_HEIGHT);
    if width < MIN_VIEWPORT_WIDTH && height < MIN_VIEWPORT_HEIGHT {
        case.fail("Too small viewport".to_string(), "Fail");
        return;
    }

    let seed = de_int32_hash(de_string_hash(test_name) as i32);
    let mut rng = Random::new(seed);
    let mut buffer_data = gen_random_coords(rng, 0, buffer_size);
    patch_nice_quad_markers(&mut buffer_data, offset, size);

    let gl_texture = Texture::new(gl);
    let gl_buffer_obj = Buffer::new(gl);
    // SAFETY: plain object creation/binding on the current context; `size` is the
    // caller's own texture-buffer range, which `check_support` already established the
    // driver accepts when non-zero.
    unsafe {
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, gl_buffer_obj.get());
        gl.buffer_data(
            glw::GL_TEXTURE_BUFFER,
            buffer_data.len() as isize,
            buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0);

        gl.bind_texture(glw::GL_TEXTURE_BUFFER, gl_texture.get());
        if offset != 0 || size != 0 {
            gl.tex_buffer_range(
                glw::GL_TEXTURE_BUFFER,
                glw::GL_RGBA8,
                gl_buffer_obj.get(),
                offset as isize,
                size as isize,
            );
        } else {
            gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA8, gl_buffer_obj.get());
        }
        gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0);
    }
    if let Err(e) = crate::glu::expect_no_error(gl, "texture buffer setup") {
        case.fail(e.to_string(), "Fail");
        return;
    }

    let mut reference = match TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        width as u32,
        height as u32,
        1,
    ) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };
    clear(&mut reference.get_access(), CLEAR_COLOR.m_data);

    // SAFETY: a plain viewport/clear of the bound (default) framebuffer.
    unsafe {
        gl.viewport(0, 0, width, height);
        gl.clear_color(CLEAR_COLOR.x(), CLEAR_COLOR.y(), CLEAR_COLOR.z(), CLEAR_COLOR.w());
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let context = case.context();

    if let Some(e) = pre_render.and_then(|pre| {
        do_render(
            context,
            pre,
            &mut rng,
            gl_buffer_obj.get(),
            gl_texture.get(),
            max_texture_buffer_size,
            &buffer_data,
            offset,
            size,
            &mut reference,
        )
        .err()
    }) {
        case.fail(e, "Fail");
        return;
    }

    if let Some(e) =
        modify.and_then(|m| apply_modify(case, m, &mut rng, gl_buffer_obj.get(), &mut buffer_data, offset, size).err())
    {
        case.fail(e, "Fail");
        return;
    }

    if let Some(e) = post_render.and_then(|post| {
        do_render(
            context,
            post,
            &mut rng,
            gl_buffer_obj.get(),
            gl_texture.get(),
            max_texture_buffer_size,
            &buffer_data,
            offset,
            size,
            &mut reference,
        )
        .err()
    }) {
        case.fail(e, "Fail");
        return;
    }

    verify_screen(case, &reference);
}

/// `TextureBufferCase::iterate`, `render`-group scope only: `preRender`/`modify` are
/// always none, `postRender` is `render`.
pub fn render_case(
    case: &mut ApiCase<'_>,
    test_name: &str,
    buffer_size: usize,
    offset_units: usize,
    size: usize,
    render: RenderBits,
) {
    run_case(
        case,
        test_name,
        buffer_size,
        offset_units,
        size,
        None,
        None,
        Some(render),
    );
}
