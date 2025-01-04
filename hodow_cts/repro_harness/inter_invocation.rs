// The twenty `synchronization.inter_invocation.*` compute shaders, generated the way
// upstream generates them.
//
// Four storages (`ssbo`, `ssbo_atomic`, `image`, `image_atomic`) times five access
// patterns (`write_read`, `read_write`, `overwrite`, `alias_write`, `alias_overwrite`).
// Every one of them is the same shape - write, synchronise across the work group, read
// back and check - and they differ only in which GLSL statements go in which order, which
// is why the one that hangs and the one beside it that does not are worth generating from
// the same code: the difference between them is then visible rather than asserted.
//
// Transcribed from VK-GL-CTS `es31fSynchronizationTests.cpp`, `InterInvocationTestCase`
// and its four subclasses, via hodow_cts' port of it.

#![allow(dead_code)]

pub const WORK_WIDTH: i32 = 256;
pub const WORK_HEIGHT: i32 = 256;
pub const LOCAL_WIDTH: i32 = 16;
pub const LOCAL_HEIGHT: i32 = 8;
pub const ELEMENTS_PER_INVOCATION: i32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Storage {
    Buffer,
    Image,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    WriteRead,
    ReadWrite,
    OverWrite,
    AliasWrite,
    AliasOverwrite,
}

pub struct Variant {
    pub name: &'static str,
    pub storage: Storage,
    pub atomic: bool,
    pub kind: Kind,
}

impl Variant {
    pub fn aliasing(&self) -> bool {
        matches!(self.kind, Kind::AliasWrite | Kind::AliasOverwrite)
    }

    pub fn uses_images(&self) -> bool {
        self.storage == Storage::Image
    }

    /// The storage the shader reads and writes, at the bindings it declares. An aliasing
    /// variant binds the same object twice, which is what "alias" means here.
    pub fn bind_storage(&self, gl: &crate::gl::Gl) {
        if self.uses_images() {
            let tex = gl.image_2d(
                crate::gl::GL_R32I,
                crate::gl::GL_RED_INTEGER,
                crate::gl::GL_INT,
                WORK_WIDTH,
                WORK_HEIGHT * ELEMENTS_PER_INVOCATION,
            );
            for binding in 1..=if self.aliasing() { 2 } else { 1 } {
                unsafe { (gl.bind_image_texture)(binding, tex, 0, crate::gl::GL_FALSE, 0, crate::gl::GL_READ_WRITE, crate::gl::GL_R32I) };
            }
        } else {
            let zeros = vec![0i32; (WORK_WIDTH * WORK_HEIGHT * ELEMENTS_PER_INVOCATION) as usize];
            for binding in 1..=if self.aliasing() { 2 } else { 1 } {
                gl.ssbo_i32(binding, &zeros);
            }
        }
    }

    fn storage_name(&self, index: u32) -> &'static str {
        match (self.storage, self.aliasing(), index) {
            (Storage::Buffer, false, _) => "sb_store",
            (Storage::Buffer, true, 0) => "sb_store0",
            (Storage::Buffer, true, _) => "sb_store1",
            (Storage::Image, false, _) => "u_image",
            (Storage::Image, true, 0) => "u_image0",
            (Storage::Image, true, _) => "u_image1",
        }
    }

    /// `inter_invocation` always synchronises across the whole work group, which is what
    /// makes a read of *another* invocation's slot meaningful.
    fn barrier(&self) -> &'static str {
        "\n    groupMemoryBarrier();\n    barrier();\n\n"
    }

    fn local_id(&self, x_offset: i32, y_offset: i32) -> String {
        format!("(gl_LocalInvocationID.xy + uvec2({x_offset}, {y_offset})) % gl_WorkGroupSize.xy")
    }

    fn group_ndx_value(&self) -> &'static str {
        match self.storage {
            Storage::Buffer => "groupNdx",
            Storage::Image => "int(groupNdx)",
        }
    }

    fn write_own(&self, store: &str, value: &str, ndx: i32) -> String {
        match (self.storage, self.atomic) {
            (Storage::Buffer, true) => format!("\tatomicAdd({store}.values[getIndex(gl_LocalInvocationID.xy, {ndx})], {value});\n"),
            (Storage::Buffer, false) => format!("\t{store}.values[getIndex(gl_LocalInvocationID.xy, {ndx})] = {value};\n"),
            (Storage::Image, true) => format!("\timageAtomicAdd({store}, getCoord(gl_LocalInvocationID.xy, {ndx}), {value});\n"),
            (Storage::Image, false) => format!("\timageStore({store}, getCoord(gl_LocalInvocationID.xy, {ndx}), ivec4({value}, 0, 0, 0));\n"),
        }
    }

    fn overwrite(&self, store: &str, local_id: &str, ndx: i32) -> String {
        match (self.storage, self.atomic) {
            (Storage::Buffer, true) => format!("\tatomicExchange({store}.values[getIndex({local_id}, {ndx})], groupNdx);\n"),
            (Storage::Buffer, false) => format!("\t{store}.values[getIndex({local_id}, {ndx})] = groupNdx;\n"),
            (Storage::Image, true) => format!("\timageAtomicExchange({store}, getCoord({local_id}, {ndx}), groupNdx);\n"),
            (Storage::Image, false) => format!("\timageStore({store}, getCoord({local_id}, {ndx}), ivec4(groupNdx, 0, 0, 0));\n"),
        }
    }

    fn read_check(&self, store: &str, local_id: &str, ndx: i32, written: i32, expected: &str) -> String {
        match (self.storage, self.atomic) {
            (Storage::Buffer, true) => format!("\tallOk = allOk && (atomicExchange({store}.values[getIndex({local_id}, {ndx})], {written}) == {expected});\n"),
            (Storage::Buffer, false) => format!("\tallOk = allOk && ({store}.values[getIndex({local_id}, {ndx})] == {expected});\n"),
            (Storage::Image, true) => format!("\tallOk = allOk && (imageAtomicExchange({store}, getCoord({local_id}, {ndx}), {written}) == {expected});\n"),
            (Storage::Image, false) => format!("\tallOk = allOk && (imageLoad({store}, getCoord({local_id}, {ndx})).x == {expected});\n"),
        }
    }

    fn body(&self) -> String {
        let mut buf = String::new();
        let store = self.storage_name(0);
        match self.kind {
            Kind::WriteRead => {
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.write_own(store, self.group_ndx_value(), ndx));
                }
                buf.push_str(self.barrier());
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.read_check(store, &self.local_id(ndx + 1, 2 * ndx), ndx, 0, "groupNdx"));
                }
            }
            Kind::ReadWrite => {
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.read_check(store, &self.local_id(ndx + 1, 2 * ndx), ndx, 123, "0"));
                }
                buf.push_str(self.barrier());
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.write_own(store, self.group_ndx_value(), ndx));
                }
            }
            Kind::OverWrite => {
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.write_own(store, "456", ndx));
                }
                buf.push_str(self.barrier());
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.overwrite(store, &self.local_id(ndx + 4, 3 * ndx), ndx));
                }
                buf.push_str(self.barrier());
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.read_check(store, &self.local_id(ndx + 1, 2 * ndx), ndx, 123, "groupNdx"));
                }
            }
            Kind::AliasWrite | Kind::AliasOverwrite => {
                let store1 = self.storage_name(1);
                if self.kind == Kind::AliasOverwrite {
                    for ndx in 0..ELEMENTS_PER_INVOCATION {
                        buf.push_str(&self.write_own(store, "456", ndx));
                    }
                    buf.push_str(self.barrier());
                }
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.overwrite(store1, &self.local_id(ndx + 2, 2 * ndx), ndx));
                }
                buf.push_str(self.barrier());
                for ndx in 0..ELEMENTS_PER_INVOCATION {
                    buf.push_str(&self.read_check(store, "gl_LocalInvocationID.xy", ndx, 123, "groupNdx"));
                }
            }
        }
        buf
    }

    pub fn shader(&self) -> String {
        let mut s = String::new();
        s.push_str("#version 310 es\n");
        if self.atomic && self.storage == Storage::Image {
            // Upstream's ${SHADER_IMAGE_ATOMIC_REQUIRE}. ES 3.2 has it in core, ES 3.1
            // needs the extension, and asking for it on 3.2 is harmless.
            s.push_str("#extension GL_OES_shader_image_atomic : require\n");
        }
        s.push_str(&format!("layout (local_size_x={LOCAL_WIDTH}, local_size_y={LOCAL_HEIGHT}) in;\n"));
        s.push_str("layout(binding=0, std430) buffer Output\n{\n    highp int values[];\n} sb_result;\n");

        if self.storage == Storage::Buffer {
            if self.aliasing() {
                s.push_str("layout(binding=1, std430) coherent buffer Storage0\n{\n    highp int values[];\n} sb_store0;\n");
                s.push_str("layout(binding=2, std430) coherent buffer Storage1\n{\n    highp int values[];\n} sb_store1;\n");
            } else {
                s.push_str("layout(binding=1, std430) coherent buffer Storage\n{\n    highp int values[];\n} sb_store;\n");
            }
            s.push_str("\nhighp int getIndex (in highp uvec2 localID, in highp int element)\n{\n");
            s.push_str("    highp uint groupNdx = gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;\n");
            s.push_str(&format!(
                "    return int((localID.y * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x) + (groupNdx * gl_WorkGroupSize.x) + localID.x) * {ELEMENTS_PER_INVOCATION} + element;\n}}\n"
            ));
        } else {
            if self.aliasing() {
                s.push_str("layout(r32i, binding=1) coherent uniform highp iimage2D u_image0;\n");
                s.push_str("layout(r32i, binding=2) coherent uniform highp iimage2D u_image1;\n");
            } else {
                s.push_str("layout(r32i, binding=1) coherent uniform highp iimage2D u_image;\n");
            }
            s.push_str("\nhighp ivec2 getCoord (in highp uvec2 localID, in highp int element)\n{\n");
            s.push_str(&format!(
                "    return ivec2(int(gl_WorkGroupID.x * gl_WorkGroupSize.x + localID.x), int(gl_WorkGroupID.y * gl_WorkGroupSize.y + localID.y) + element * {WORK_HEIGHT});\n}}\n"
            ));
        }

        s.push_str("\nvoid main (void)\n{\n");
        s.push_str("    int resultNdx   = int(gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x + gl_GlobalInvocationID.x);\n");
        s.push_str("    int groupNdx    = int(gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x);\n");
        s.push_str("    bool allOk      = true;\n\n");
        s.push_str(&self.body());
        s.push_str("\n    sb_result.values[resultNdx] = (allOk) ? (1) : (0);\n}\n");
        s
    }
}

/// All twenty, named exactly as the conformance suite names them.
pub const VARIANTS: &[Variant] = &[
    Variant { name: "ssbo_write_read", storage: Storage::Buffer, atomic: false, kind: Kind::WriteRead },
    Variant { name: "ssbo_read_write", storage: Storage::Buffer, atomic: false, kind: Kind::ReadWrite },
    Variant { name: "ssbo_overwrite", storage: Storage::Buffer, atomic: false, kind: Kind::OverWrite },
    Variant { name: "ssbo_alias_write", storage: Storage::Buffer, atomic: false, kind: Kind::AliasWrite },
    Variant { name: "ssbo_alias_overwrite", storage: Storage::Buffer, atomic: false, kind: Kind::AliasOverwrite },
    Variant { name: "ssbo_atomic_write_read", storage: Storage::Buffer, atomic: true, kind: Kind::WriteRead },
    Variant { name: "ssbo_atomic_read_write", storage: Storage::Buffer, atomic: true, kind: Kind::ReadWrite },
    Variant { name: "ssbo_atomic_overwrite", storage: Storage::Buffer, atomic: true, kind: Kind::OverWrite },
    Variant { name: "ssbo_atomic_alias_write", storage: Storage::Buffer, atomic: true, kind: Kind::AliasWrite },
    Variant { name: "ssbo_atomic_alias_overwrite", storage: Storage::Buffer, atomic: true, kind: Kind::AliasOverwrite },
    Variant { name: "image_write_read", storage: Storage::Image, atomic: false, kind: Kind::WriteRead },
    Variant { name: "image_read_write", storage: Storage::Image, atomic: false, kind: Kind::ReadWrite },
    Variant { name: "image_overwrite", storage: Storage::Image, atomic: false, kind: Kind::OverWrite },
    Variant { name: "image_alias_write", storage: Storage::Image, atomic: false, kind: Kind::AliasWrite },
    Variant { name: "image_alias_overwrite", storage: Storage::Image, atomic: false, kind: Kind::AliasOverwrite },
    Variant { name: "image_atomic_write_read", storage: Storage::Image, atomic: true, kind: Kind::WriteRead },
    Variant { name: "image_atomic_read_write", storage: Storage::Image, atomic: true, kind: Kind::ReadWrite },
    Variant { name: "image_atomic_overwrite", storage: Storage::Image, atomic: true, kind: Kind::OverWrite },
    Variant { name: "image_atomic_alias_write", storage: Storage::Image, atomic: true, kind: Kind::AliasWrite },
    Variant { name: "image_atomic_alias_overwrite", storage: Storage::Image, atomic: true, kind: Kind::AliasOverwrite },
];

pub fn by_name(name: &str) -> Option<&'static Variant> {
    VARIANTS.iter().find(|v| v.name == name)
}
