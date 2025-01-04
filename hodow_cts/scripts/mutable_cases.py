"""Transliteration of the shader side of vktBindingMutableTests.cpp (dEQP-VK.binding_model.mutable_descriptor.*).

`MutableTypesTest::initPrograms` builds its GLSL from the descriptor set of the case, so the sources come from here; the Rust side
(`src/vkt/tests/binding_model/mutable_tests.rs`) keeps the same descriptor-set model and names every set with the key written by `set_keys`.
Acceleration structures are read with ray queries in the stages that are not ray tracing ones; the ray tracing stages get a passthrough ray generation shader.
"""

SAMPLER = "sampler"
COMBINED = "combined_image_sampler"
SAMPLED_IMAGE = "sampled_image"
STORAGE_IMAGE = "storage_image"
UNIFORM_TEXEL = "uniform_texel_buffer"
STORAGE_TEXEL = "storage_texel_buffer"
UNIFORM_BUFFER = "uniform_buffer"
STORAGE_BUFFER = "storage_buffer"
INPUT_ATTACHMENT = "input_attachment"
ACCEL = "acceleration_structure_khr"
MUTABLE = "mutable"

BASIC_TYPES = [SAMPLER, COMBINED, SAMPLED_IMAGE, STORAGE_IMAGE, UNIFORM_TEXEL, STORAGE_TEXEL, UNIFORM_BUFFER, STORAGE_BUFFER, INPUT_ATTACHMENT, ACCEL]
MANDATORY_TYPES = [SAMPLED_IMAGE, STORAGE_IMAGE, UNIFORM_TEXEL, STORAGE_TEXEL, UNIFORM_BUFFER, STORAGE_BUFFER]

# DescriptorTypeFlagBits order, which toDescriptorTypeVector walks
FLAG_ORDER = [SAMPLER, COMBINED, SAMPLED_IMAGE, STORAGE_IMAGE, UNIFORM_TEXEL, STORAGE_TEXEL, UNIFORM_BUFFER, STORAGE_BUFFER, INPUT_ATTACHMENT, ACCEL, MUTABLE]

EXTERNAL_IMAGE_VALUE = 0x41322314
STORED_VALUE_MASK = 0xFF000000


def numeric_value(iteration, binding_idx, descriptor_idx=0):
    return 0x5A000000 | ((iteration & 0xFF) << 16) | ((binding_idx & 0xFF) << 8) | (descriptor_idx & 0xFF)


def to_hex(v):
    return "0x%xu" % v


class Single:
    def __init__(self, type_, mutable_types=()):
        self.type = type_
        self.mutable_types = list(mutable_types)

    def max_types(self):
        return 1 if self.type != MUTABLE else len(self.mutable_types)

    def used_types(self):
        return [self.type] if self.type != MUTABLE else list(self.mutable_types)

    def types_at_iteration(self, it):
        t = self.used_types()
        return [t[it % len(t)]]

    def type_at_iteration(self, it):
        return self.types_at_iteration(it)[0]

    is_array = False
    is_unbounded = False

    def size(self):
        return 1

    def needs_aliasing(self, it):
        return len(set(self.types_at_iteration(it))) > 1

    def declarations(self, it, set_num, binding_num, ia_idx, array_size):
        t = self.type_at_iteration(it)
        if array_size is None:
            arr = ""
        else:
            arr = "[]" if array_size < 0 else "[%d]" % array_size
        layout = "set=%d, binding=%d" % (set_num, binding_num)
        bs = "_%d_%d" % (set_num, binding_num)
        ns = bs + arr
        s = "layout ("
        if t == SAMPLER:
            s += layout + ") uniform sampler sampler" + ns
        elif t == COMBINED:
            s += layout + ") uniform usampler2D combinedSampler" + ns
        elif t == SAMPLED_IMAGE:
            s += layout + ") uniform utexture2D sampledImage" + ns
        elif t == UNIFORM_BUFFER:
            s += layout + ") uniform uboBlock" + bs + " { uint val; } ubo" + ns
        elif t == STORAGE_BUFFER:
            s += layout + ") buffer sboBlock" + bs + " { uint val; } ssbo" + ns
        elif t == UNIFORM_TEXEL:
            s += layout + ") uniform utextureBuffer uniformTexel" + ns
        elif t == STORAGE_TEXEL:
            s += layout + ", r32ui) uniform uimageBuffer storageTexel" + ns
        elif t == STORAGE_IMAGE:
            s += layout + ", r32ui) uniform uimage2D storageImage" + ns
        elif t == INPUT_ATTACHMENT:
            s += layout + ", input_attachment_index=%d) uniform usubpassInput inputAttachment" % ia_idx + ns
        elif t == ACCEL:
            s += layout + ") uniform accelerationStructureEXT accelerationStructure" + ns
        else:
            raise AssertionError(t)
        return s + ";\n"

    def checks(self, it, set_num, binding_num, base_value, array_index, use_pc):
        t = self.type_at_iteration(it)
        bs = "_%d_%d" % (set_num, binding_num)
        idx = ""
        if array_index is not None:
            idx = str(array_index)
            if use_pc:
                idx += " + pc.zero"
            idx = "[" + idx + "]"
        ns = bs + idx
        base = to_hex(base_value)
        ext = to_hex(EXTERNAL_IMAGE_VALUE)
        mask = to_hex(STORED_VALUE_MASK)
        printf = '      debugPrintfEXT("iteration-%d%s: 0x%%xu\\n", readValue);\n' % (it, ns)
        c = "    {\n"
        if t == SAMPLER:
            c += "      uint readValue = texture(usampler2D(externalSampledImage, sampler" + ns + "), vec2(0, 0)).r;\n"
            c += printf
            c += "      anyError |= ((readValue == " + ext + ") ? 0u : 1u);\n"
        elif t == COMBINED:
            c += "      uint readValue = texture(combinedSampler" + ns + ", vec2(0, 0)).r;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
        elif t == SAMPLED_IMAGE:
            c += "      uint readValue = texture(usampler2D(sampledImage" + ns + ", externalSampler), vec2(0, 0)).r;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
        elif t == UNIFORM_BUFFER:
            c += "      uint readValue = ubo" + ns + ".val;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
        elif t == STORAGE_BUFFER:
            c += "      uint readValue = ssbo" + ns + ".val;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
            c += "      ssbo" + ns + ".val = (readValue | " + mask + ");\n"
        elif t == UNIFORM_TEXEL:
            c += "      uint readValue = texelFetch(uniformTexel" + ns + ", 0).x;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
        elif t == STORAGE_TEXEL:
            c += "      uint readValue = imageLoad(storageTexel" + ns + ", 0).x;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
            c += "      readValue |= " + mask + ";\n"
            c += "      imageStore(storageTexel" + ns + ", 0, uvec4(readValue, 0, 0, 0));\n"
        elif t == STORAGE_IMAGE:
            c += "      uint readValue = imageLoad(storageImage" + ns + ", ivec2(0, 0)).x;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
            c += "      readValue |= " + mask + ";\n"
            c += "      imageStore(storageImage" + ns + ", ivec2(0, 0), uvec4(readValue, 0, 0, 0));\n"
        elif t == INPUT_ATTACHMENT:
            c += "      uint readValue = subpassLoad(inputAttachment" + ns + ").x;\n" + printf
            c += "      anyError |= ((readValue == " + base + ") ? 0u : 1u);\n"
        elif t == ACCEL:
            c += "      const uint cullMask = 0xFF;\n"
            c += "      const vec3 origin = vec3(%d.0, 0.0, 0.0);\n" % (base_value & 0xFFFF)
            c += "      const vec3 direction = vec3(0.0, 0.0, 1.0);\n"
            c += "      const float tmin = 1.0;\n"
            c += "      const float tmax = 10.0;\n"
            c += "      uint candidateFound = 0u;\n"
            c += "      rayQueryEXT rq;\n"
            c += "      rayQueryInitializeEXT(rq, accelerationStructure" + ns + ", gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);\n"
            c += "      while (rayQueryProceedEXT(rq)) {\n"
            c += "        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);\n"
            c += "        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {\n"
            c += "          candidateFound = 1u;\n"
            c += "        }\n"
            c += "      }\n"
            c += "      anyError |= ((candidateFound == 1u) ? 0u : 1u);\n"
        else:
            raise AssertionError(t)
        return c + "    }\n"


class Array:
    is_array = True

    def __init__(self, unbounded, bindings):
        self.is_unbounded = unbounded
        self.bindings = bindings

    def max_types(self):
        return max(len(b.used_types()) for b in self.bindings)

    def types_at_iteration(self, it):
        return [b.type_at_iteration(it) for b in self.bindings]

    def size(self):
        return len(self.bindings)

    def needs_aliasing(self, it):
        return len(set(self.types_at_iteration(it))) > 1

    def declarations(self, it, set_num, binding_num, ia_idx, array_size):
        n = len(self.bindings)
        array_size_val = -1 if self.is_unbounded else n
        if not self.needs_aliasing(it):
            return self.bindings[0].declarations(it, set_num, binding_num, ia_idx, array_size_val)
        types = self.types_at_iteration(it)
        used = set()
        out = ""
        for i in range(n):
            if types[i] in used:
                continue
            used.add(types[i])
            out += self.bindings[i].declarations(it, set_num, binding_num, ia_idx, array_size_val)
        return out

    def checks(self, it, set_num, binding_num, base_value, array_index, use_pc):
        assert array_index is None
        out = ""
        for i, b in enumerate(self.bindings):
            out += b.checks(it, set_num, binding_num, base_value + i, i, use_pc)
        return out


class DescriptorSet:
    def __init__(self, bindings):
        self.bindings = bindings

    def max_types(self):
        return max(b.max_types() for b in self.bindings)

    def contains_type_at_iteration(self, t, it):
        return any(t in b.types_at_iteration(it) for b in self.bindings)

    def contains_any(self, t):
        return any(self.contains_type_at_iteration(t, i) for i in range(self.max_types()))

    def has_arrays(self):
        return any(b.is_array for b in self.bindings)

    def needs_any_aliasing(self):
        return any(any(b.needs_aliasing(i) for b in self.bindings) for i in range(self.max_types()))


STAGE_NAMES = {"comp": "comp", "vert": "vert", "tesc": "tesc", "tese": "tese", "geom": "geom", "frag": "frag",
               "rgen": "rgen", "isec": "isec", "ahit": "ahit", "chit": "chit", "miss": "miss", "call": "call"}
ALL_STAGES = ["comp", "vert", "tesc", "tese", "geom", "frag", "rgen", "isec", "ahit", "chit", "miss", "call"]
REDUCED_STAGES = ["comp", "vert", "frag", "rgen"]
COMPUTE_ONLY = ["comp"]
RAY_STAGES = {"rgen", "isec", "ahit", "chit", "miss", "call"}

VERTEX_PREAMBLE = "vec2 vertexPositions[3] = vec2[](\n  vec2(0.0, -0.5),\n  vec2(0.5, 0.5),\n  vec2(-0.5, 0.5)\n);\n"
VERTEX_BODY = "  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);\n"
TESC_PREAMBLE = ("layout (vertices=3) out;\nin gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_in[gl_MaxPatchVertices];\n"
                 "out gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_out[];\n")
TESC_BODY = ("  gl_TessLevelInner[0] = 1.0;\n  gl_TessLevelInner[1] = 1.0;\n  gl_TessLevelOuter[0] = 1.0;\n  gl_TessLevelOuter[1] = 1.0;\n"
             "  gl_TessLevelOuter[2] = 1.0;\n  gl_TessLevelOuter[3] = 1.0;\n  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n")
TESE_PREAMBLE = ("layout (triangles, fractional_odd_spacing, cw) in;\nin gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_in[gl_MaxPatchVertices];\n"
                 "out gl_PerVertex\n{\n  vec4 gl_Position;\n};\n")
TESE_BODY = ("  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +\n                (gl_TessCoord.y * gl_in[1].gl_Position) +\n"
             "                (gl_TessCoord.z * gl_in[2].gl_Position);\n")


def uses_ray_queries(ds):
    return ds.contains_any(ACCEL)


def is_stub(ds, stage):
    return False


def init_programs(ds, stage, use_pc):
    """Returns {program name: (glslang stage, source)}."""
    use_external_image = ds.contains_any(SAMPLER)
    use_external_sampler = ds.contains_any(SAMPLED_IMAGE)
    num_iterations = ds.max_types()
    num_bindings = len(ds.bindings)

    extra_set = ""
    extra_bindings = 0
    extra_set += "layout (set=1, binding=%d) buffer OutputBufferBlock { uint value[%d]; } outputBuffer;\n" % (extra_bindings, num_iterations)
    extra_bindings += 1
    if use_external_image:
        extra_set += "layout (set=1, binding=%d) uniform utexture2D externalSampledImage;\n" % extra_bindings
        extra_bindings += 1
    if use_external_sampler:
        extra_set += "layout (set=1, binding=%d) uniform sampler externalSampler;\n" % extra_bindings
        extra_bindings += 1

    preamble = "#version 460\n#extension GL_EXT_nonuniform_qualifier : enable\n#extension GL_EXT_debug_printf : enable\n"
    ray_tracing = stage in RAY_STAGES
    if ray_tracing:
        preamble += "#extension GL_EXT_ray_tracing : enable\n"
    if uses_ray_queries(ds):
        preamble += "#extension GL_EXT_ray_query : enable\n"
    preamble += "\n"
    if stage == "vert":
        preamble += VERTEX_PREAMBLE
    elif stage == "comp":
        preamble += "layout (local_size_x=1, local_size_y=1, local_size_z=1) in;\n\n"
    elif stage == "geom":
        preamble += ("layout (triangles) in;\nlayout (triangle_strip, max_vertices=3) out;\nin gl_PerVertex\n{\n  vec4 gl_Position;\n} gl_in[3];\n"
                     "out gl_PerVertex\n{\n  vec4 gl_Position;\n};\n")
    elif stage == "tesc":
        preamble += TESC_PREAMBLE
    elif stage == "tese":
        preamble += TESE_PREAMBLE
    elif stage == "call":
        preamble += "layout (location=0) callableDataInEXT float unusedCallableData;\n"
    elif stage in ("chit", "ahit", "miss"):
        preamble += "layout (location=0) rayPayloadInEXT float unusedRayPayload;\n"
    elif stage == "isec":
        preamble += "hitAttributeEXT vec3 hitAttribute;\n"
    preamble += extra_set
    if use_pc:
        preamble += "layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;\n"
    preamble += "\n"

    programs = {}
    for it in range(num_iterations):
        shader = preamble
        input_attachment_count = 0
        for bi, b in enumerate(ds.bindings):
            types = b.types_at_iteration(it)
            has_ia = INPUT_ATTACHMENT in types
            if b.is_array:
                array_size = -1 if b.is_unbounded else b.size()
            else:
                array_size = None
            shader += b.declarations(it, 0, bi, input_attachment_count, array_size)
            if has_ia:
                input_attachment_count += 1
        shader += "\nvoid main() {\n"
        shader += "  const uint flag = atomicCompSwap(outputBuffer.value[%d], 0u, 1u);\n" % it
        shader += "  if (flag == 0u) {\n    uint anyError = 0u;\n"
        for bi, b in enumerate(ds.bindings):
            shader += b.checks(it, 0, bi, numeric_value(it, bi), None, use_pc)
        shader += "    if (anyError == 0u) {\n      atomicAdd(outputBuffer.value[%d], 1u);\n    }\n  }\n" % it
        if stage == "vert":
            shader += VERTEX_BODY
        elif stage == "geom":
            shader += ("  gl_Position = gl_in[0].gl_Position; EmitVertex();\n  gl_Position = gl_in[1].gl_Position; EmitVertex();\n"
                       "  gl_Position = gl_in[2].gl_Position; EmitVertex();\n")
        elif stage == "tesc":
            shader += TESC_BODY
        elif stage == "tese":
            shader += TESE_BODY
        shader += "}\n"
        programs["iteration-%d" % it] = (stage, shader)

    if stage in ("frag", "geom", "tesc", "tese"):
        programs["vert"] = ("vert", "#version 460\nout gl_PerVertex\n{\n  vec4 gl_Position;\n};\n" + VERTEX_PREAMBLE + "void main() {\n" + VERTEX_BODY + "}\n")
    if stage == "tesc":
        programs["tese"] = ("tese", "#version 460\n" + TESE_PREAMBLE + "void main (void)\n{\n" + TESE_BODY + "}\n")
    if stage == "tese":
        programs["tesc"] = ("tesc", "#version 460\n" + TESC_PREAMBLE + "void main (void)\n{\n" + TESC_BODY + "}\n")
    if ray_tracing and stage != "rgen":
        # A passthrough ray generation shader that traces the extra acceleration structure
        rgen = "#version 460 core\n#extension GL_EXT_ray_tracing : require\n"
        rgen += "layout (set=1, binding=%d) uniform accelerationStructureEXT externalAS;\n" % extra_bindings
        if stage == "call":
            rgen += "layout (location=0) callableDataEXT float unusedCallableData;\n"
        else:
            rgen += "layout (location=0) rayPayloadEXT float unusedRayPayload;\n"
        rgen += "\nvoid main()\n{\n"
        if stage in ("isec", "ahit", "chit", "miss"):
            z_dir = "-1.0" if stage == "miss" else "1.0"
            rgen += "  const uint cullMask = 0xFF;\n  const float tMin = 1.0;\n  const float tMax = 10.0;\n"
            rgen += "  const vec3 origin = vec3(0.0, 0.0, 0.0);\n  const vec3 direction = vec3(0.0, 0.0, %s);\n" % z_dir
            rgen += "  traceRayEXT(externalAS, gl_RayFlagsNoneEXT, cullMask, 0, 0, 0, origin, tMin, direction, tMax, 0);\n"
        elif stage == "call":
            rgen += "  executeCallableEXT(0, 0);\n"
        rgen += "}\n"
        programs["rgen"] = ("rgen", rgen)
        if stage == "isec":
            # Intersection shaders ignore the intersection, so a passthrough miss shader is needed
            programs["miss"] = ("miss", "#version 460 core\n#extension GL_EXT_ray_tracing : require\n"
                                "layout (location=0) rayPayloadEXT float unusedRayPayload;\n\nvoid main()\n{\n}\n")
    return programs


def rotate(lst, n):
    return lst[n:] + lst[:n]


def set_cases():
    """Yields (set key, DescriptorSet, stage list) for every set createChildren builds, in its order."""
    for t in BASIC_TYPES:
        yield "single." + t, DescriptorSet([Single(MUTABLE, [t])]), ALL_STAGES
    yield "single.all_mandatory", DescriptorSet([Single(MUTABLE, MANDATORY_TYPES)]), REDUCED_STAGES
    for a in BASIC_TYPES:
        for b in BASIC_TYPES:
            if a == b:
                continue
            yield "single.switches.%s_%s" % (a, b), DescriptorSet([Single(MUTABLE, [a, b])]), REDUCED_STAGES
    for t in BASIC_TYPES:
        yield "single_nonmutable." + t, DescriptorSet([Single(t)]), REDUCED_STAGES

    variants = [(True, False, "one_array"), (False, False, "multiple_arrays"), (False, True, "multiple_arrays_mixed")]
    for one_array_only, mix_non_mutable, group in variants:
        for unbounded, uname in ((False, "constant_size"), (True, "unbounded")):
            for aliasing, aname in ((False, "noaliasing"), (True, "aliasing")):
                bindings = []
                for rot in range(len(MANDATORY_TYPES)):
                    is_last = one_array_only or rot == len(MANDATORY_TYPES) - 1
                    is_unbounded = unbounded and is_last
                    vec = rotate(MANDATORY_TYPES, rot)
                    if aliasing:
                        arr = [Single(MUTABLE, rotate(vec, i)) for i in range(len(vec))]
                    else:
                        arr = [Single(MUTABLE, vec) for _ in vec]
                    bindings.append(Array(is_unbounded, arr))
                    if mix_non_mutable and not is_unbounded:
                        bindings.append(Array(False, [Single(MANDATORY_TYPES[rot]) for _ in MANDATORY_TYPES]))
                    if one_array_only:
                        break
                yield "%s.%s.%s" % (group, uname, aname), DescriptorSet(bindings), COMPUTE_ONLY

    for t in BASIC_TYPES:
        if t == INPUT_ATTACHMENT or t in MANDATORY_TYPES:
            continue
        for aliasing, aname in ((False, "noaliasing"), (True, "aliasing")):
            types = MANDATORY_TYPES + [t]
            bindings = [Single(MUTABLE, types)]
            if aliasing:
                arr = [Single(MUTABLE, rotate(types, i)) for i in range(len(types))]
            else:
                arr = [Single(MUTABLE, types) for _ in types]
            bindings.append(Array(False, arr))
            yield "single_and_array.%s.%s" % (t, aname), DescriptorSet(bindings), COMPUTE_ONLY

    for mixed in (False, True):
        bindings = []
        for i in range(len(MANDATORY_TYPES)):
            rotated = rotate(MANDATORY_TYPES, i)
            bindings.append(Single(MUTABLE, rotated))
            if mixed:
                bindings.append(Single(rotated[0]))
        yield "multiple.%s" % ("mixed" if mixed else "mutable_only"), DescriptorSet(bindings), COMPUTE_ONLY

    for non_mut in range(3):
        for mut in range(1, 3):
            bindings = [Single(UNIFORM_BUFFER) for _ in range(non_mut)] + [Single(MUTABLE, [STORAGE_BUFFER]) for _ in range(mut)]
            yield "misc.out_of_range_%d%d" % (non_mut, mut), DescriptorSet(bindings), COMPUTE_ONLY


def shader_keys():
    """Yields (key, ds, stage, use_pc) for every shader set the non-stub cases need."""
    for key, ds, stages in set_cases():
        has_arrays = ds.has_arrays()
        has_ia = ds.contains_any(INPUT_ATTACHMENT)
        pcs = [True, False] if has_arrays else [False]
        for stage in stages:
            if has_ia and stage != "frag":
                continue
            if is_stub(ds, stage):
                continue
            for pc in pcs:
                yield "%s.%s.%s" % (key, stage, "pc" if pc else "nopc"), ds, stage, pc
