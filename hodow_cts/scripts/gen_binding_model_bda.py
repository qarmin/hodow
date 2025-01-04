# Expands the shaders and manifest of dEQP-VK.binding_model.buffer_device_address.{set*, misc.copy_struct}.
# Usage: python3 -I hodow_cts/scripts/gen_binding_model_bda.py <repo root>, then just cts-shaders.
# Mirrors BufferAddressTestCase::initPrograms / checkBuffer and the case loops of createBufferDeviceAddressTests().
import hashlib
import os
import sys

DIM = 8
BASE_UBO, BASE_SSBO = 0, 1
STAGE_COMPUTE, STAGE_VERTEX, STAGE_FRAGMENT = 0, 1, 2
(CONVERT_NONE, CONVERT_UINT64, CONVERT_UVEC2, CONVERT_U64CMP, CONVERT_UVEC2CMP, CONVERT_UVEC2TOU64, CONVERT_U64TOUVEC2) = range(7)
BT_SINGLE, BT_MULTI, BT_REPLAY = 0, 1, 2
LAYOUT_STD140, LAYOUT_SCALAR = 0, 1

SETS = [0, 3, 7, 15, 31]
DEPTHS = [1, 2, 3]
BASES = [BASE_UBO, BASE_SSBO]
CVTS = [CONVERT_NONE, CONVERT_UINT64, CONVERT_UVEC2, CONVERT_U64CMP, CONVERT_UVEC2CMP, CONVERT_UVEC2TOU64, CONVERT_U64TOUVEC2]
STORES = [0, 1]
BTS = [BT_SINGLE, BT_MULTI, BT_REPLAY]
LAYOUTS = [LAYOUT_STD140, LAYOUT_SCALAR]
STAGES = [STAGE_COMPUTE, STAGE_FRAGMENT, STAGE_VERTEX]
OFFSETS = [0, 1]

EXTENSIONS = ("#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable\n"
              "#extension GL_EXT_buffer_reference : enable\n"
              "#extension GL_EXT_scalar_block_layout : enable\n"
              "#extension GL_EXT_buffer_reference_uvec2 : enable\n")


def check_buffer(c, buf_num, cur_depth, prefix):
    out = ""
    cvt = c["cvt"]
    new_prefix = prefix
    if cur_depth > 0:
        if cvt in (CONVERT_UINT64, CONVERT_UVEC2TOU64):
            new_prefix = "T1(uint64_t(T1(" + new_prefix + ")))"
        elif cvt in (CONVERT_UVEC2, CONVERT_U64TOUVEC2):
            new_prefix = "T1(uvec2(T1(" + new_prefix + ")))"

    if c["store"] and cur_depth != 0:
        local_name = "l%d" % buf_num
        out += "   " + ("restrict " if buf_num & 1 else "") + "T1 " + local_name + " = " + new_prefix + ";\n"
        new_prefix = local_name

    out += "   accum |= %s.a[0] - %d;\n" % (new_prefix, buf_num * 3 + 0)
    out += "   accum |= %s.a[pc.identity[1]] - %d;\n" % (new_prefix, buf_num * 3 + 1)
    out += "   accum |= %s.b - %d;\n" % (new_prefix, buf_num * 3 + 2)
    out += "   accum |= int(%s.e[0][0] - %d);\n" % (new_prefix, buf_num * 3 + 3)
    out += "   accum |= int(%s.e[0][1] - %d);\n" % (new_prefix, buf_num * 3 + 5)
    out += "   accum |= int(%s.e[1][0] - %d);\n" % (new_prefix, buf_num * 3 + 4)
    out += "   accum |= int(%s.e[1][1] - %d);\n" % (new_prefix, buf_num * 3 + 6)

    if c["layout"] == LAYOUT_SCALAR:
        out += "   f = %s.f;\n" % new_prefix
        out += "   accum |= f.x - %d;\n" % (buf_num * 3 + 7)
        out += "   accum |= f.y - %d;\n" % (buf_num * 3 + 8)
        out += "   accum |= f.z - %d;\n" % (buf_num * 3 + 9)

    lp = "l%d" % buf_num

    if cvt in (CONVERT_U64CMP, CONVERT_UVEC2CMP):
        t = "uint64_t" if cvt == CONVERT_U64CMP else "uvec2"
        out += "   %s %sc0 = %s(%s.c[0]);\n" % (t, lp, t, new_prefix)
        out += "   %s %sc1 = %s(%s.c[pc.identity[1]]);\n" % (t, lp, t, new_prefix)
        out += "   %s %sd  = %s(%s.d);\n" % (t, lp, t, new_prefix)

    if cur_depth != c["depth"]:
        if cvt == CONVERT_U64CMP:
            out += ("   if (%sc0 == zero ||\n       %sc1 == zero ||\n       %sd  == zero ||\n       %sc0 == %sc1 ||\n"
                    "       %sc1 == %sd  ||\n       %sc0 == %sd  ) {\n     accum |= 1;\n   }\n") % (lp, lp, lp, lp, lp, lp, lp, lp, lp)
        elif cvt == CONVERT_UVEC2CMP:
            out += ("   if (all(equal(%sc0, zero)) ||\n       all(equal(%sc1, zero)) ||\n       all(equal(%sd , zero)) ||\n"
                    "       all(equal(%sc0, %sc1)) ||\n       all(equal(%sc1, %sd )) ||\n       all(equal(%sc0, %sd )) ) {\n     accum |= 1;\n   }\n") % (
                lp, lp, lp, lp, lp, lp, lp, lp, lp)
        out += check_buffer(c, buf_num * 3 + 1, cur_depth + 1, new_prefix + ".c[0]")
        out += check_buffer(c, buf_num * 3 + 2, cur_depth + 1, new_prefix + ".c[pc.identity[1]]")
        out += check_buffer(c, buf_num * 3 + 3, cur_depth + 1, new_prefix + ".d")
    else:
        if cvt == CONVERT_U64CMP:
            out += ("   if (!(%sc0 == %sc1 &&\n         %sc1 == %sd  &&\n         %sc0 == %sd  )) {\n     accum |= 1;\n   }\n") % (lp, lp, lp, lp, lp, lp)
        elif cvt == CONVERT_UVEC2CMP:
            out += ("   if (!(all(equal(%sc0, %sc1)) &&\n         all(equal(%sc1, %sd )) &&\n         all(equal(%sc0, %sd )) )) {\n     accum |= 1;\n   }\n") % (
                lp, lp, lp, lp, lp, lp)
    return out


def gen_shader(c):
    base_storage = "uniform" if c["base"] == BASE_UBO else "buffer"
    member_storage = "buffer"
    decls = "layout(r32ui, set = %d, binding = 0) uniform uimage2D image0_0;\n" % c["set"]
    decls += "layout(buffer_reference) %s T1;\n" % member_storage

    cvt = c["cvt"]
    if cvt in (CONVERT_UINT64, CONVERT_U64TOUVEC2):
        ref_type = "uint64_t"
    elif cvt in (CONVERT_UVEC2, CONVERT_UVEC2TOU64):
        ref_type = "uvec2"
    else:
        ref_type = "T1"

    layout = "scalar" if c["layout"] == LAYOUT_SCALAR else "std140"
    f_line = "   layout(offset = 36) ivec3 f;\n" if c["layout"] == LAYOUT_SCALAR else ""
    body = ("   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140\n"
            "   layout(offset = 32) int b;\n" + f_line + "   layout(offset = 48) " + ref_type +
            " c[2]; // stride = 8 for scalar, 16 for std140\n"
            "   layout(offset = 80) " + ref_type + " d;\n"
            "   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140\n")
    decls += "layout(set = %d, binding = 1, %s) %s T2 {\n" % (c["set"], layout, base_storage) + body + "} x;\n"
    decls += "layout(buffer_reference, %s) %s T1 {\n" % (layout, member_storage) + body + "};\n"

    local_decls = ""
    if cvt == CONVERT_U64CMP:
        local_decls = "  uint64_t zero = uint64_t(0);\n"
    elif cvt == CONVERT_UVEC2CMP:
        local_decls = "  uvec2 zero = uvec2(0, 0);\n"

    checks = check_buffer(c, 0, 0, "x")
    pushdecl = "layout (push_constant, std430) uniform Block { int identity[32]; } pc;\n"
    head = ("  int accum = 0, temp;\n  ivec3 f;\n" + local_decls + checks +
            "  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);\n")

    stage = c["stage"]
    if stage == STAGE_COMPUTE:
        css = ("#version 450 core\n" + EXTENSIONS + pushdecl + decls + "layout(local_size_x = 1, local_size_y = 1) in;\nvoid main()\n{\n" + head +
               "  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);\n}\n")
        return {"test": ("comp", css)}
    if stage == STAGE_VERTEX:
        vss = ("#version 450 core\n" + EXTENSIONS + pushdecl + decls + "void main()\n{\n" + head +
               "  imageStore(image0_0, ivec2(gl_VertexIndex % %d, gl_VertexIndex / %d), color);\n  gl_PointSize = 1.0f;\n}\n".replace("%d", str(DIM)))
        return {"test": ("vert", vss)}
    vss = ("#version 450 core\nvoid main()\n{\n"
           "  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);\n}\n")
    fss = ("#version 450 core\n" + EXTENSIONS + pushdecl + decls + "void main()\n{\n" + head +
           "  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);\n}\n")
    return {"vert": ("vert", vss), "test": ("frag", fss)}


COPY_STRUCT = """#version 450
#extension GL_EXT_buffer_reference : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430, buffer_reference) buffer T1 {
    int a;
};

struct Foo {
    T1 b;
};

layout(set = 0, binding = 0, std430) buffer storage_buffer {
    uint index;
    // offset 4..7 is std430 padding
    Foo f[];  // each item is 8 bytes: one buffer reference
} foo;

void main() {
    Foo new_foo = foo.f[foo.index];
    new_foo.b.a = 2;
}
"""


def all_cases():
    """The (path, params) pairs createBufferDeviceAddressTests() registers for the shader-bearing groups."""
    out = []
    for s in SETS:
        for d in DEPTHS:
            for b in BASES:
                for cvt in CVTS:
                    for st in STORES:
                        for bt in BTS:
                            for lay in LAYOUTS:
                                for stage in STAGES:
                                    for off in OFFSETS:
                                        if s != 3 and (d == 3 or lay != LAYOUT_STD140):
                                            continue
                                        if off == 1 and bt != BT_SINGLE:
                                            continue
                                        out.append(dict(set=s, depth=d, base=b, stage=stage, cvt=cvt, store=st, layout=lay, bt=bt, offset=off))
    return out


def write_all(root):
    src_dir = os.path.join(root, "hodow_cts/shaders/src/binding_model/bda")
    os.makedirs(src_dir, exist_ok=True)
    written = {}

    def put(stage, text):
        h = hashlib.sha1(text.encode()).hexdigest()[:12]
        rel = "binding_model/bda/%s.%s" % (h, stage)
        if rel not in written:
            with open(os.path.join(root, "hodow_cts/shaders/src", rel), "w") as f:
                f.write(text)
            written[rel] = 1
        return rel

    head = '''# Shader manifest for dEQP-VK.binding_model.buffer_device_address.set*.* and misc.copy_struct
#
# `BufferAddressTestCase::initPrograms`, pre-expanded by hodow_cts/scripts/gen_binding_model_bda.py over the loops of
# createBufferDeviceAddressTests(). The shader depends on the descriptor set number, the pointer depth, the base storage, the
# stage, the conversion, whether intermediate references are stored and the block layout; the buffer type (single, multi,
# replay) and the memory offset only change what the test does with it, so those cases share an entry. `convert` is the
# Convert enum (0 none, 1 uint64, 2 uvec2, 3 u64 compare, 4 uvec2 compare, 5 uvec2 to u64, 6 u64 to uvec2), `stage` 0 compute,
# 1 vertex, 2 fragment, `base` 0 uniform buffer, 1 storage buffer, `layout` 0 std140, 1 scalar. The uvec2 comparison needs
# SPIR-V 1.5 for OpBitcast, as upstream's. The op_access_chain cases and misc.multiple_access_chain are hand-written SPIR-V
# assembly and are not ported.

upstream_source = "external/vulkancts/modules/vulkan/binding_model/vktBindingBufferDeviceAddressTests.cpp"
rust_module = "binding_model/buffer_device_address_tests"

[[case]]
name = "copy_struct"
rust_const = "BDA_COPY_STRUCT"
rust_type = "SharedProgram"
programs = [{ name = "comp", template = "%s", stage = "comp" }]

''' % put("comp", COPY_STRUCT)
    out = [head]
    seen = {}
    n = 0
    for c in all_cases():
        key = (c["set"], c["depth"], c["base"], c["stage"], c["cvt"], c["store"], c["layout"])
        if key in seen:
            continue
        seen[key] = n
        progs = []
        for name, (stage, text) in gen_shader(c).items():
            rel = put(stage, text)
            version = ', spirv_version = "spirv1.5"' if c["cvt"] == CONVERT_UVEC2CMP else ""
            progs.append('    { name = "%s", template = "%s", stage = "%s"%s },' % (name, rel, stage, version))
        out.append('[[case]]\nname = "bda%d"\nrust_const = "BDA_%d"\nrust_type = "BufferAddressPrograms"\nprograms = [\n%s\n]\n'
                   'params = { set = { type = "u32", value = %d }, depth = { type = "u32", value = %d }, base = { type = "u32", value = %d }, '
                   'stage = { type = "u32", value = %d }, convert = { type = "u32", value = %d }, store = { type = "bool", value = %s }, '
                   'layout = { type = "u32", value = %d } }\n'
                   % (n, n, "\n".join(progs), c["set"], c["depth"], c["base"], c["stage"], c["cvt"], "true" if c["store"] else "false", c["layout"]))
        n += 1
    with open(os.path.join(root, "hodow_cts/shaders/manifest/binding_model_buffer_device_address.toml"), "w") as f:
        f.write("\n".join(out))
    return n, len(written)


if __name__ == "__main__":
    cases = all_cases()
    print("cases", len(cases))
    if len(sys.argv) > 1:
        print(write_all(sys.argv[1]))
