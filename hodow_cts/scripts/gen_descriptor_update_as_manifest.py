#!/usr/bin/env python3
"""Writes the shaders of dEQP-VK.binding_model.descriptor_update.acceleration_structure.* (vktBindingDescriptorUpdateASTests.cpp, every `initPrograms`) and their manifest.

A pure text generator: no glslang and no cargo.   Run from hodow_cts/:  python3 scripts/gen_descriptor_update_as_manifest.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "binding_model" / "descriptor_update_as"
MANIFEST = ROOT / "shaders" / "manifest" / "binding_model_descriptor_update_as.toml"
TEMPLATE_DIR = "binding_model/descriptor_update_as"

WIDTH = 16
HEIGHT = 16
FIXED_POINT_DIVISOR = 1024 * 1024

V = "#version 460\n"

MISS_PASS = V + "#extension GL_EXT_ray_tracing : require\n\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\n\nvoid main()\n{\n}\n"
HIT_PASS = V + "#extension GL_EXT_ray_tracing : require\nhitAttributeEXT vec3 attribs;\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\n\nvoid main()\n{\n}\n"
GRAPHICS_PASS = V + "\nvoid main(void)\n{\n}\n"
VERTEX_PASS = V + "\nlayout(location = 0) in vec4 in_position;\n\nvoid main(void)\n{\n  gl_Position = in_position;\n}\n"

RQ_BODY = (
    f"  const float mult     = {FIXED_POINT_DIVISOR}.0f;\n"
    "  uint        rayFlags = 0;\n"
    "  uint        cullMask = 0xFF;\n"
    "  float       tmin     = 0.0;\n"
    "  float       tmax     = 9.0;\n"
    "  vec3        origin   = vec3((float(pos.x) + 0.5f) / float(size.x), (float(pos.y) + 0.5f) / float(size.y), 0.0);\n"
    "  vec3        direct   = vec3(0.0, 0.0, 1.0);\n"
    "  int         value    = 0;\n"
    "  rayQueryEXT rayQuery;\n"
    "\n"
    "  rayQueryInitializeEXT(rayQuery, tlas, rayFlags, cullMask, origin, tmin, direct, tmax);\n"
    "\n"
    "  while(rayQueryProceedEXT(rayQuery))\n"
    "  {\n"
    "    if (rayQueryGetIntersectionTypeEXT(rayQuery, false) == gl_RayQueryCandidateIntersectionTriangleEXT)\n"
    "    {\n"
    "      const float t = rayQueryGetIntersectionTEXT(rayQuery, false);"
    "\n"
    "      value = int(round(mult * t));\n"
    "    }\n"
    "  }\n"
    "\n"
    "  imageStore(result, pos, ivec4(value, 0, 0, 0));\n"
)

RT_BODY = (
    f"  const float mult     = {FIXED_POINT_DIVISOR}.0f;\n"
    "  int         value    = int(round(mult * gl_HitTEXT));\n"
    "\n"
    "  imageStore(result, pos, ivec4(value, 0, 0, 0));\n"
)

BINDINGS = (
    "layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;\n"
    "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n"
)

COMPUTE_PREFIX = "  ivec3       pos      = ivec3(gl_WorkGroupID);\n  ivec3       size     = ivec3(gl_NumWorkGroups);\n"
RT_PREFIX = "  ivec3       pos      = ivec3(gl_LaunchIDEXT);\n  ivec3       size     = ivec3(gl_LaunchSizeEXT);\n"

COMMON_RGEN = (
    V
    + "\n#extension GL_EXT_ray_tracing : require\n\n"
    + "layout(location = 0) rayPayloadEXT vec3 hitValue;\n"
    + "layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;\n\n"
    + "void main()\n{\n"
    + "  uint  rayFlags = 0;\n  uint  cullMask = 0xFF;\n  float tmin     = 0.0;\n  float tmax     = 9.0;\n"
    + "  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);\n"
    + "  vec3  direct   = vec3(0.0, 0.0, -1.0);\n"
    + "  traceRayEXT(topLevelAS, rayFlags, cullMask, 0, 0, 0, origin, tmin, direct, tmax, 0);\n}\n"
)

files: dict[str, str] = {}


def add(name: str, text: str) -> str:
    files[name] = text
    return f"{TEMPLATE_DIR}/{name}"


common = {
    "miss_pass.rmiss": MISS_PASS,
    "ahit_pass.rahit": HIT_PASS,
    "chit_pass.rchit": HIT_PASS,
    "graphics_pass.frag": GRAPHICS_PASS,
    "vertex_pass.vert": VERTEX_PASS,
    "common.rgen": COMMON_RGEN,
}
for n, t in common.items():
    add(n, t)

SIZE_DECL = f"ivec3({WIDTH}, {HEIGHT}, 1)"


def rq_graphics(stage: str) -> list[tuple[str, str, str]]:
    """(program name, file, glsl stage) of each program."""
    body = RQ_BODY
    if stage == "vert":
        text = (
            V + "#extension GL_EXT_ray_query : require\n#extension GL_EXT_ray_tracing : require\n\n" + BINDINGS + "\n"
            "void testFunc(ivec3 pos, ivec3 size)\n{\n" + body + "}\n\n"
            "void main(void)\n{\n"
            "  const int   posId    = int(gl_VertexIndex / 3);\n"
            "  const int   vertId   = int(gl_VertexIndex % 3);\n"
            f"  const ivec3 size     = {SIZE_DECL};\n"
            "  const ivec3 pos      = ivec3(posId % size.x, posId / size.x, 0);\n\n"
            "  if (vertId == 0)\n  {\n    testFunc(pos, size);\n  }\n}\n"
        )
        return [("vert", add("rq_vert.vert", text), "vert"), ("frag", f"{TEMPLATE_DIR}/graphics_pass.frag", "frag")]
    gl_pervertex_in = "in gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_in[];\n"
    gl_pervertex_out = "out gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_out[];\n"
    tesc_plain = (
        V + "#extension GL_EXT_tessellation_shader : require\n\n" + gl_pervertex_in + "layout(vertices = 3) out;\n" + gl_pervertex_out + "\n"
        "void main(void)\n{\n"
        "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
        "  gl_TessLevelInner[0] = 1;\n  gl_TessLevelInner[1] = 1;\n  gl_TessLevelOuter[gl_InvocationID] = 1;\n}\n"
    )
    tese_plain = (
        V + "#extension GL_EXT_tessellation_shader : require\nlayout(triangles, equal_spacing, ccw) in;\n\n" + gl_pervertex_in + "\n"
        "void main(void)\n{\n  gl_Position = gl_in[0].gl_Position;\n}\n"
    )
    vert_in = (
        V + "\nlayout(location = 0) in vec4 in_position;\nout gl_PerVertex\n{\n  vec4 gl_Position;\n};\n\n"
        "void main(void)\n{\n  gl_Position = in_position;\n}\n"
    )
    if stage == "tesc":
        text = (
            V + "#extension GL_EXT_tessellation_shader : require\n#extension GL_EXT_ray_query : require\n\n" + BINDINGS + "\n"
            + gl_pervertex_in + "layout(vertices = 3) out;\n" + gl_pervertex_out + "\n"
            "void testFunc(ivec3 pos, ivec3 size)\n{\n" + body + "}\n\n"
            "void main(void)\n{\n\n"
            "  if (gl_InvocationID == 0)\n  {\n"
            f"    const ivec3 size = {SIZE_DECL};\n"
            "    int index = int(gl_in[gl_InvocationID].gl_Position.z);\n"
            "    int x = index % size.x;\n    int y = index / size.y;\n"
            "    const ivec3 pos = ivec3(x, y, 0);\n    testFunc(pos, size);\n  }\n\n"
            "  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
            "  gl_TessLevelInner[0] = 1;\n  gl_TessLevelInner[1] = 1;\n  gl_TessLevelOuter[gl_InvocationID] = 1;\n}\n"
        )
        return [
            ("vert", add("rq_tesc_vert.vert", vert_in), "vert"),
            ("tesc", add("rq_tesc.tesc", text), "tesc"),
            ("tese", add("tese_plain.tese", tese_plain), "tese"),
        ]
    if stage == "tese":
        text = (
            V + "#extension GL_EXT_tessellation_shader : require\n#extension GL_EXT_ray_query : require\n\n" + BINDINGS + "\n"
            "layout(triangles, equal_spacing, ccw) in;\n" + gl_pervertex_in + "\n"
            "void testFunc(ivec3 pos, ivec3 size)\n{\n" + body + "}\n\n"
            "void main(void)\n{\n"
            f"    const ivec3 size = {SIZE_DECL};\n"
            "    int index = int(gl_in[0].gl_Position.z);\n"
            "    int x = index % size.x;\n    int y = index / size.y;\n"
            "    const ivec3 pos = ivec3(x, y, 0);\n    testFunc(pos, size);\n    gl_Position = gl_in[0].gl_Position;\n}\n"
        )
        return [
            ("vert", add("rq_tese_vert.vert", vert_in), "vert"),
            ("tesc", add("tesc_plain.tesc", tesc_plain), "tesc"),
            ("tese", add("rq_tese.tese", text), "tese"),
        ]
    if stage == "geom":
        text = (
            V + "#extension GL_EXT_ray_query : require\n\nlayout(triangles) in;\nlayout(points, max_vertices = 1) out;\n\n" + BINDINGS + "\n"
            "void testFunc(ivec3 pos, ivec3 size)\n{\n" + body + "}\n\n"
            "void main(void)\n{\n"
            "  const int   posId    = int(gl_PrimitiveIDIn);\n"
            f"  const ivec3 size     = {SIZE_DECL};\n"
            "  const ivec3 pos      = ivec3(posId % size.x, posId / size.x, 0);\n\n"
            "  testFunc(pos, size);\n  gl_PointSize = 1.0;\n}\n"
        )
        return [("vert", f"{TEMPLATE_DIR}/vertex_pass.vert", "vert"), ("geom", add("rq_geom.geom", text), "geom")]
    if stage == "frag":
        text = (
            V + "#extension GL_EXT_ray_query : require\n\n" + BINDINGS + "\n"
            "void testFunc(ivec3 pos, ivec3 size)\n{\n" + body + "}\n\n"
            "void main(void)\n{\n"
            f"  const ivec3 size     = {SIZE_DECL};\n"
            "  const ivec3 pos      = ivec3(int(gl_FragCoord.x - 0.5f), int(gl_FragCoord.y - 0.5f), 0);\n\n"
            "  testFunc(pos, size);\n}\n"
        )
        return [("vert", f"{TEMPLATE_DIR}/vertex_pass.vert", "vert"), ("frag", add("rq_frag.frag", text), "frag")]
    raise ValueError(stage)


def rq_rt(stage: str) -> list[tuple[str, str, str]]:
    test_body = RT_PREFIX + RQ_BODY
    rgen_common = (f"{TEMPLATE_DIR}/common.rgen", "rgen")
    ahit_p = (f"{TEMPLATE_DIR}/ahit_pass.rahit", "ahit")
    chit_p = (f"{TEMPLATE_DIR}/chit_pass.rchit", "chit")
    miss_p = (f"{TEMPLATE_DIR}/miss_pass.rmiss", "miss")

    def prog(name, pair):
        return (name, pair[0], pair[1])

    ext = "#extension GL_EXT_ray_tracing : require\n#extension GL_EXT_ray_query : require\n"
    if stage == "rgen":
        text = V + "#extension GL_EXT_ray_tracing : require\n#extension GL_EXT_ray_query : require\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "}\n"
        return [("rgen", add("rq_rgen.rgen", text), "rgen")]
    if stage == "ahit":
        text = (
            V + ext + "\nhitAttributeEXT vec3 attribs;\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "}\n"
        )
        return [prog("rgen", rgen_common), ("ahit", add("rq_ahit.rahit", text), "ahit"), prog("chit", chit_p), prog("miss", miss_p)]
    if stage == "chit":
        text = (
            V + ext + "\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\nhitAttributeEXT vec3 attribs;\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "}\n"
        )
        return [prog("rgen", rgen_common), ("chit", add("rq_chit.rchit", text), "chit"), prog("ahit", ahit_p), prog("miss", miss_p)]
    if stage == "sect":
        text = (
            V + ext + "hitAttributeEXT vec3 hitAttribute;\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "  hitAttribute = vec3(0.0f, 0.0f, 0.0f);\n  reportIntersectionEXT(1.0f, 0);\n}\n"
        )
        return [prog("rgen", rgen_common), ("sect", add("rq_sect.rint", text), "isec"), prog("ahit", ahit_p), prog("chit", chit_p), prog("miss", miss_p)]
    if stage == "miss":
        text = V + ext + "layout(location = 0) rayPayloadInEXT vec3 hitValue;\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "}\n"
        return [prog("rgen", rgen_common), ("miss", add("rq_miss.rmiss", text), "miss"), prog("ahit", ahit_p), prog("chit", chit_p)]
    if stage == "call":
        rgen = (
            V + "\n" + ext + "\nlayout(location = 0) callableDataEXT float dummy;"
            "layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;\n\nvoid main()\n{\n  executeCallableEXT(0, 0);\n}\n"
        )
        call = (
            V + "\n" + ext + "layout(location = 0) callableDataInEXT float dummy;\n\n" + BINDINGS + "\nvoid main()\n{\n" + test_body + "}\n"
        )
        return [
            ("rgen", add("rq_call.rgen", rgen), "rgen"),
            ("call", add("rq_call.rcall", call), "call"),
            prog("ahit", ahit_p),
            prog("chit", chit_p),
            prog("miss", miss_p),
        ]
    raise ValueError(stage)


def rq_compute() -> list[tuple[str, str, str]]:
    text = V + "#extension GL_EXT_ray_query : require\n\n" + BINDINGS + "\nvoid main()\n{\n" + COMPUTE_PREFIX + RQ_BODY + "}\n"
    return [("comp", add("rq_comp.comp", text), "comp")]


def rt_programs(stage: str) -> list[tuple[str, str, str]]:
    test_body = RT_PREFIX + RT_BODY
    out_chit0 = (
        V + "\n#extension GL_EXT_ray_tracing : require\n\nhitAttributeEXT vec3 attribs;\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\n"
        "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n\nvoid main()\n{\n" + test_body + "}\n"
    )
    in_fragment = (
        "  uint  rayFlags = 0;\n  uint  cullMask = 0xFF;\n  float tmin     = 0.0;\n  float tmax     = 9.0;\n"
        "  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);\n"
        "  vec3  direct   = vec3(0.0, 0.0, 1.0);\n\n"
        "  traceRayEXT(topLevelAS, rayFlags, cullMask, 1, 0, 1, origin, tmin, direct, tmax, 0);\n"
    )
    common_rgen = (
        V + "\n#extension GL_EXT_ray_tracing : require\n\nlayout(location = 0) rayPayloadEXT vec3 hitValue;\n"
        "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n"
        "layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;\n\nvoid main()\n{\n"
        "  uint  rayFlags = 0;\n  uint  cullMask = 0xFF;\n  float tmin     = 0.0;\n  float tmax     = 9.0;\n"
        "  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);\n"
        "  vec3  direct   = vec3(0.0, 0.0, -1.0);\n\n"
        "  traceRayEXT(topLevelAS, rayFlags, cullMask, 0, 0, 0, origin, tmin, direct, tmax, 0);\n}\n"
    )
    base = [
        ("chit0", add("rt_chit0.rchit", out_chit0), "chit"),
        ("ahit0", f"{TEMPLATE_DIR}/ahit_pass.rahit", "ahit"),
        ("miss0", f"{TEMPLATE_DIR}/miss_pass.rmiss", "miss"),
    ]
    ahit_p = ("ahit", f"{TEMPLATE_DIR}/ahit_pass.rahit", "ahit")
    chit_p = ("chit", f"{TEMPLATE_DIR}/chit_pass.rchit", "chit")
    miss_p = ("miss", f"{TEMPLATE_DIR}/miss_pass.rmiss", "miss")
    if stage == "rgen":
        text = (
            V + "\n#extension GL_EXT_ray_tracing : require\n\nlayout(location = 0) rayPayloadEXT vec3 hitValue;\n"
            "layout(set = 0, binding = 0) uniform accelerationStructureEXT topLevelAS;\n"
            "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n\nvoid main()\n{\n" + in_fragment + "}\n"
        )
        return base + [("rgen", add("rt_rgen.rgen", text), "rgen"), chit_p, ahit_p, miss_p]
    if stage == "chit":
        text = (
            V + "\n#extension GL_EXT_ray_tracing : require\n\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\nhitAttributeEXT vec3 attribs;\n\n"
            "layout(set = 0, binding = 0) uniform accelerationStructureEXT topLevelAS;\n"
            "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n\nvoid main()\n{\n" + in_fragment + "}\n"
        )
        return base + [("rgen", add("rt_common.rgen", common_rgen), "rgen"), ("chit", add("rt_chit.rchit", text), "chit"), ahit_p, miss_p]
    if stage == "miss":
        text = (
            V + "\n#extension GL_EXT_ray_tracing : require\nlayout(location = 0) rayPayloadInEXT vec3 hitValue;\n\n"
            "layout(set = 0, binding = 0) uniform accelerationStructureEXT topLevelAS;\n"
            "layout(set = 1, binding = 0, r32i) uniform iimage3D result;\n\nvoid main()\n{\n" + in_fragment + "}\n"
        )
        return base + [("rgen", add("rt_common.rgen", common_rgen), "rgen"), ("miss", add("rt_miss.rmiss", text), "miss"), ahit_p, chit_p]
    raise ValueError(stage)


cases: list[tuple[str, list[tuple[str, str, str]]]] = []
for stage in ["vert", "tesc", "tese", "geom", "frag"]:
    cases.append((f"RQ_{stage.upper()}", rq_graphics(stage)))
cases.append(("RQ_COMP", rq_compute()))
for stage in ["rgen", "ahit", "chit", "sect", "miss", "call"]:
    cases.append((f"RQ_{stage.upper()}", rq_rt(stage)))
for stage in ["rgen", "chit", "miss"]:
    cases.append((f"RT_{stage.upper()}", rt_programs(stage)))

SRC.mkdir(parents=True, exist_ok=True)
for name, text in files.items():
    (SRC / name).write_text(text)

lines = [
    "# Shader manifest for dEQP-VK.binding_model.descriptor_update.acceleration_structure.*",
    "#",
    "# Generated by scripts/gen_descriptor_update_as_manifest.py from the `initPrograms` of vktBindingDescriptorUpdateASTests.cpp; do not edit.",
    "",
    'upstream_source = "external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorUpdateASTests.cpp"',
    'rust_module = "binding_model/descriptor_update_as_tests"',
    "",
]
for const, programs in cases:
    lines += ["[[case]]", f'name = "{const.lower()}"', f'rust_const = "{const}"', 'rust_type = "SharedProgram"', "programs = ["]
    for pname, template, stage in programs:
        lines.append(f'    {{ name = "{pname}", template = "{template}", stage = "{stage}", spirv_version = "spirv1.4" }},')
    lines += ["]", ""]
MANIFEST.write_text("\n".join(lines))
print(f"{len(files)} shader files, {len(cases)} cases")
