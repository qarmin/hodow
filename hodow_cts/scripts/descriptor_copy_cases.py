"""Transliteration of the case and shader side of vktBindingDescriptorCopyTests.cpp (dEQP-VK.binding_model.descriptor_copy.*).

`DescriptorCopyTestCase::initPrograms` writes the verification shader from the descriptors of the case, whose ids come from a counter that every
`DescriptorCommands` resets, so each case is rebuilt here exactly as `addDescriptorCopyTests` & co build it. The Rust side
(`src/vkt/tests/binding_model/descriptor_copy_tests.rs`) only runs the generated case table `descriptor_copy_table.rs`.
"""

UBO, DYN_UBO, SSBO, DYN_SSBO, UTB, STB, IUB, INPUT, COMBINED, SAMPLED, SAMPLER, STORAGE_IMAGE = range(12)
KIND_NAMES = ["UniformBuffer", "DynamicUniformBuffer", "StorageBuffer", "DynamicStorageBuffer", "UniformTexelBuffer", "StorageTexelBuffer",
              "InlineUniformBlock", "InputAttachment", "CombinedImageSampler", "SampledImage", "Sampler", "StorageImage"]
DYNAMIC = (DYN_UBO, DYN_SSBO)
IUB_ELEMENT_BYTES = 16
COMPUTE, GRAPHICS = "compute", "graphics"


class Descriptor:
    next_id = 0xABC
    next_attachment_index = 0

    def __init__(self, kind, array_size=1, write_start=0, elements_to_write=1, num_dynamic_areas=1):
        self.kind = kind
        self.array_size = array_size
        self.write_start = write_start
        self.elements_to_write = elements_to_write
        # every class but the dynamic buffers hands 1 to the base class
        self.areas = num_dynamic_areas if kind in DYNAMIC else 1
        self.id = Descriptor.next_id
        Descriptor.next_id += 1
        self.data = []
        for idx in range(array_size):
            written = write_start <= idx < write_start + elements_to_write
            self.data.append({"data": [self.id + idx * self.areas + a for a in range(self.areas)], "written": written, "copied": False})
        self.dynamic_areas = []
        self.samplers = []  # SampledImage: the Sampler descriptors, one per element
        self.images = []  # Sampler: the SampledImage descriptors, one per element
        self.original_attachment = Descriptor.next_attachment_index
        self.attachment_indices = []
        if kind == INPUT:
            for _ in range(array_size):
                self.attachment_indices.append(Descriptor.next_attachment_index)
                Descriptor.next_attachment_index += 1

    def add_image(self, image, count=1):
        self.images += [image] * count

    def add_sampler(self, sampler, count=1):
        self.samplers += [sampler] * count

    def copy_value(self, src, src_element, dst_element, count):
        for i in range(count):
            for a in range(min(self.areas, src.areas)):
                self.data[i + dst_element]["data"][a] = src.data[i + src_element]["data"][a]
            self.data[i + dst_element]["copied"] = True
        if self.kind == INPUT:
            for i in range(count):
                self.attachment_indices[i + dst_element] = src.attachment_indices[i + src_element]

    def arr(self, index):
        return "[%d]" % index if self.array_size > 1 else ""

    def declaration(self):
        i = self.id
        a = self.arr(self.array_size)
        k = self.kind
        if k == UBO:
            return ") uniform UniformBuffer%d\n{\n    int data;\n} uniformBuffer%d%s;\n" % (i, i, a)
        if k == DYN_UBO:
            return ") uniform UniformBuffer%d\n{\n    int data;\n} dynamicUniformBuffer%d%s;\n" % (i, i, a)
        if k == SSBO:
            return ") buffer StorageBuffer%d\n{\n    int data;\n} storageBuffer%d%s;\n" % (i, i, a)
        if k == DYN_SSBO:
            return ") buffer StorageBuffer%d\n{\n    int data;\n} dynamicStorageBuffer%d%s;\n" % (i, i, a)
        if k == UTB:
            return ") uniform textureBuffer uniformTexelBuffer%d%s;\n" % (i, a)
        if k == STB:
            return ", r32f) uniform imageBuffer storageTexelBuffer%d%s;\n" % (i, a)
        if k == IUB:
            return ") uniform InlineUniformBlock%d\n{\n    int data%s;\n} inlineUniformBlock%d;\n" % (i, a, i)
        if k == INPUT:
            return ", input_attachment_index=%d) uniform subpassInput inputAttachment%d%s;\n" % (self.original_attachment, i, a)
        if k == COMBINED:
            return ") uniform sampler2D texSampler%d%s;\n" % (i, a)
        if k == SAMPLED:
            return ") uniform texture2D sampledImage%d%s;\n" % (i, a)
        if k == STORAGE_IMAGE:
            return ", r32f) readonly uniform image2D image%d%s;\n" % (i, a)
        if k == SAMPLER:
            return ") uniform sampler sampler%d%s;\n" % (i, a)
        raise AssertionError(k)

    def verify_code(self):
        i = self.id
        out = ""
        for idx in range(self.array_size):
            d = self.data[idx]
            used = d["written"] or d["copied"]
            k = self.kind
            at = self.arr(idx)
            if k == UBO and used:
                out += "if (uniformBuffer%d%s.data != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == DYN_UBO and used:
                out += "if (dynamicUniformBuffer%d%s.data != %d) result = 0;\n" % (i, at, d["data"][self.dynamic_areas[idx]])
            elif k == SSBO and used:
                out += "if (storageBuffer%d%s.data != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == DYN_SSBO and used:
                out += "if (dynamicStorageBuffer%d%s.data != %d) result = 0;\n" % (i, at, d["data"][self.dynamic_areas[idx]])
            elif k == UTB and used:
                out += "if (texelFetch(uniformTexelBuffer%d%s, 0).x != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == STB and used:
                out += "if (imageLoad(storageTexelBuffer%d%s, 0).x != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == IUB and used:
                out += "if (inlineUniformBlock%d.data%s != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == INPUT and used:
                out += "if (subpassLoad(inputAttachment%d%s).x != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == COMBINED and used:
                out += "if (texture(texSampler%d%s, vec2(0)).x != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == SAMPLED and used and len(self.samplers) > idx:
                out += "if (texture(sampler2D(sampledImage%d%s, sampler%d), vec2(0)).x != %d) result = 0;\n" % (i, at, self.samplers[idx].id, d["data"][0])
            elif k == STORAGE_IMAGE and used:
                out += "if (imageLoad(image%d%s, ivec2(0)).x != %d) result = 0;\n" % (i, at, d["data"][0])
            elif k == SAMPLER and used and len(self.images) > idx:
                out += "if (texture(sampler2D(sampledImage%d, sampler%d%s), vec2(-1)).x != %d) result = 0;\n" % (self.images[idx].id, i, at, d["data"][0] % 2)
        return out


class Commands:
    def __init__(self, pipeline, uab):
        Descriptor.next_id = 0xABC
        Descriptor.next_attachment_index = 0
        self.pipeline = pipeline
        self.uab = uab
        self.sets = []  # lists of descriptors
        self.copies = []  # (srcSet, srcBinding, srcElem, dstSet, dstBinding, dstElem, count), IUB ones in bytes
        self.descriptors = []
        self.result = None
        self.dynamic_areas = []

    def add_descriptor(self, desc, set_index):
        while len(self.sets) <= set_index:
            self.sets.append([])
        self.sets[set_index].append(desc)
        desc.set = set_index
        self.descriptors.append(desc)

    def copy(self, ss, sb, se, ds, db, de, count):
        c = [ss, sb, se, ds, db, de, count]
        if self.sets[ss][sb].kind == IUB:
            c[2] *= IUB_ELEMENT_BYTES
            c[5] *= IUB_ELEMENT_BYTES
            c[6] *= IUB_ELEMENT_BYTES
        self.copies.append(tuple(c))
        self.sets[ds][db].copy_value(self.sets[ss][sb], se, de, count)

    def copy1(self, ss, sb, ds, db):
        self.copy(ss, sb, 0, ds, db, 0, 1)

    def add_result_buffer(self):
        if self.pipeline == COMPUTE:
            self.result = Descriptor(SSBO)
            self.add_descriptor(self.result, 0)

    def set_dynamic_areas(self, areas):
        self.dynamic_areas = list(areas)
        n = 0
        for d in self.descriptors:
            if d.kind in DYNAMIC:
                d.dynamic_areas = []
                for _ in range(d.array_size):
                    d.dynamic_areas.append(areas[n])
                    n += 1

    def declarations(self):
        out = ""
        for si, s in enumerate(self.sets):
            for bi, d in enumerate(s):
                out += "layout (set=%d, binding=%d" % (si, bi) + d.declaration()
        return out

    def verifications(self):
        out = ""
        for si, s in enumerate(self.sets):
            for bi, d in enumerate(s):
                if self.pipeline == COMPUTE and si == 0 and bi == len(s) - 1:
                    continue
                out += d.verify_code()
        return out

    def programs(self):
        if self.pipeline == COMPUTE:
            src = ("#version 430\n\n" + self.declarations() + "\nvoid main()\n{\nint result = 1;\n" + self.verifications()
                   + "storageBuffer%d.data = result;\n}\n" % self.result.id)
            return {"compute": ("comp", src)}
        vertex = ("#version 450\nout gl_PerVertex\n{\n    vec4 gl_Position;\n};\nvoid main()\n{\n"
                  "    gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,\n"
                  "                       ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);\n}\n")
        fragment = ("#version 430\n\n" + self.declarations() + "layout (location = 0) out vec4 outColor;\n\nvoid main()\n{\nint result = 1;\n"
                    + self.verifications() + "if (result == 1) outColor = vec4(0, 1, 0, 1);\nelse outColor = vec4(1, 0, 1, 0);\n}\n")
        return {"vertex": ("vert", vertex), "fragment": ("frag", fragment)}


def add_descriptor_copy_tests(kind, name, pipeline, uab, out):
    def case(suffix, build):
        c = Commands(pipeline, uab)
        build(c)
        out.append((name + suffix, c))

    def T(*args):
        return Descriptor(kind, *args)

    def b0(c):
        c.add_descriptor(T(1, 0, 1, 3), 0); c.add_descriptor(T(1, 0, 1, 2), 0)
        c.copy1(0, 0, 0, 1); c.set_dynamic_areas([2, 1]); c.add_result_buffer()
    case("_0", b0)

    def b1(c):
        c.add_descriptor(T(1, 0, 1, 2), 0); c.add_descriptor(T(1, 0, 1, 4), 1)
        c.copy1(0, 0, 1, 0); c.set_dynamic_areas([0, 1]); c.add_result_buffer()
    case("_1", b1)

    def b2(c):
        c.add_descriptor(T(1, 0, 1, 2), 0); c.add_descriptor(T(1, 0, 0, 1), 1)
        c.copy1(0, 0, 1, 0); c.set_dynamic_areas([1, 0]); c.add_result_buffer()
    case("_2", b2)

    def b3(c):
        c.add_descriptor(T(1, 0, 1, 3), 0); c.add_descriptor(T(1, 0, 1, 4), 0)
        c.add_descriptor(T(1, 0, 1, 2), 1); c.add_descriptor(T(1, 0, 1, 1), 1); c.add_descriptor(T(1, 0, 1, 2), 1)
        c.add_descriptor(T(1, 0, 1, 5), 4)
        c.copy1(4, 0, 0, 0); c.copy1(0, 1, 1, 2); c.copy1(0, 1, 1, 1)
        c.set_dynamic_areas([1, 0, 1, 0, 0, 4]); c.add_result_buffer()
    case("_3", b3)

    def b4(c):
        c.add_descriptor(T(1, 0, 1, 2), 0); c.add_descriptor(T(1, 0, 1, 4), 1); c.add_descriptor(T(1, 0, 1, 2), 1)
        for _ in range(100):
            c.copy1(0, 0, 1, 0)
        c.copy1(1, 1, 0, 0)
        for _ in range(100):
            c.copy1(1, 0, 1, 1)
        c.set_dynamic_areas([0, 1, 1]); c.add_result_buffer()
    case("_4", b4)

    def b5(c):
        c.add_descriptor(T(1, 0, 1, 3), 0); c.add_descriptor(T(1, 0, 1, 3), 1); c.add_descriptor(T(1, 0, 1, 3), 1)
        c.copy1(0, 0, 1, 0); c.copy1(1, 0, 0, 0); c.copy1(1, 1, 0, 0); c.copy1(1, 1, 0, 0); c.copy1(1, 0, 1, 1)
        c.set_dynamic_areas([1, 0, 0]); c.add_result_buffer()
    case("_5", b5)

    def b6(c):
        c.add_descriptor(T(1, 0, 1, 3), 0); c.add_descriptor(T(1, 0, 1, 2), 5); c.add_descriptor(T(1, 0, 1, 2), 5)
        c.copy1(0, 0, 5, 1); c.set_dynamic_areas([2, 1, 1]); c.add_result_buffer()
    case("_6", b6)

    def a0(c):
        c.add_descriptor(T(3, 0, 3, 3), 0); c.add_descriptor(T(3, 0, 3, 4), 0)
        c.copy(0, 0, 0, 0, 1, 0, 3); c.set_dynamic_areas([1, 0, 2, 2, 1, 0]); c.add_result_buffer()
    case("_array0", a0)

    def a1(c):
        c.add_descriptor(T(2, 0, 2, 2), 0); c.add_descriptor(T(3, 0, 3, 5), 1)
        c.copy(0, 0, 0, 1, 0, 0, 2); c.set_dynamic_areas([1, 0, 1, 0, 1]); c.add_result_buffer()
    case("_array1", a1)

    def a2(c):
        c.add_descriptor(T(4, 0, 4, 3), 0); c.add_descriptor(T(8, 0, 5, 4), 0)
        c.copy(0, 0, 1, 0, 1, 5, 3); c.set_dynamic_areas([2, 0, 1, 1, 2, 0, 1, 2, 0, 1, 1, 2]); c.add_result_buffer()
    case("_array2", a2)


def add_sampler_copy_tests(pipeline, uab, out):
    def case(name, build):
        c = Commands(pipeline, uab)
        build(c)
        out.append((name, c))

    def s0(c):
        sampler0, sampler1, image = Descriptor(SAMPLER), Descriptor(SAMPLER), Descriptor(SAMPLED)
        sampler0.add_image(image); sampler1.add_image(image)
        c.add_descriptor(sampler0, 0); c.add_descriptor(sampler1, 0); c.add_descriptor(image, 0)
        c.copy1(0, 0, 0, 1); c.add_result_buffer()
    case("sampler_0", s0)

    def sa0(c):
        sampler0 = Descriptor(SAMPLER, 3, 0, 3); sampler1 = Descriptor(SAMPLER); sampler2 = Descriptor(SAMPLER, 3, 0, 3); image = Descriptor(SAMPLED)
        sampler0.add_image(image, 3); sampler2.add_image(image, 3)
        c.add_descriptor(sampler0, 0); c.add_descriptor(sampler1, 0); c.add_descriptor(sampler2, 0); c.add_descriptor(image, 0)
        c.copy(0, 0, 0, 0, 2, 0, 3); c.add_result_buffer()
    case("sampler_array0", sa0)

    def sa1(c):
        sampler0 = Descriptor(SAMPLER, 2, 0, 2); sampler1 = Descriptor(SAMPLER, 3, 0, 3); image = Descriptor(SAMPLED)
        sampler0.add_image(image, 2); sampler1.add_image(image, 3)
        c.add_descriptor(sampler0, 0); c.add_descriptor(sampler1, 1); c.add_descriptor(image, 0)
        c.copy(0, 0, 0, 1, 0, 1, 2); c.add_result_buffer()
    case("sampler_array1", sa1)


def add_sampled_image_copy_tests(pipeline, uab, out):
    def case(name, build):
        c = Commands(pipeline, uab)
        build(c)
        out.append((name, c))

    def i0(c):
        sampler = Descriptor(SAMPLER); image0 = Descriptor(SAMPLED); image1 = Descriptor(SAMPLED)
        image0.add_sampler(sampler); image1.add_sampler(sampler)
        c.add_descriptor(image0, 0); c.add_descriptor(image1, 0); c.add_descriptor(sampler, 0)
        c.copy1(0, 0, 0, 1); c.add_result_buffer()
    case("sampled_image_0", i0)

    def ia0(c):
        sampler = Descriptor(SAMPLER); image0 = Descriptor(SAMPLED, 3, 0, 3); image1 = Descriptor(SAMPLED, 3, 0, 3)
        image0.add_sampler(sampler, 3); image1.add_sampler(sampler, 3)
        c.add_descriptor(sampler, 0); c.add_descriptor(image0, 0); c.add_descriptor(image1, 0)
        c.copy(0, 1, 0, 0, 2, 0, 3); c.add_result_buffer()
    case("sampled_image_array0", ia0)


def add_mixed_descriptor_copy_tests(pipeline, out):
    def case(name, build):
        c = Commands(pipeline, False)
        build(c)
        out.append((name, c))

    def mix0(c):
        sampler0, sampler1 = Descriptor(SAMPLER), Descriptor(SAMPLER)
        image0, image1 = Descriptor(SAMPLED), Descriptor(SAMPLED)
        sb0, sb1, sb2 = Descriptor(SSBO), Descriptor(SSBO), Descriptor(SSBO)
        sampler0.add_image(image0); sampler1.add_image(image1)
        c.add_descriptor(sampler0, 0); c.add_descriptor(sb0, 0); c.add_descriptor(image0, 0); c.add_descriptor(sb1, 0)
        c.add_descriptor(sampler1, 1); c.add_descriptor(image1, 1); c.add_descriptor(sb2, 1)
        c.copy1(1, 1, 0, 2); c.copy1(0, 1, 0, 3); c.copy1(0, 3, 1, 2); c.add_result_buffer()
    case("mix_0", mix0)

    def mix1(c):
        stb0, stb1 = Descriptor(STB), Descriptor(STB)
        ub0, ub1, ub2 = Descriptor(UBO), Descriptor(UBO), Descriptor(UBO)
        dsb0, dsb1 = Descriptor(DYN_SSBO, 1, 0, 1, 3), Descriptor(DYN_SSBO, 1, 0, 1, 4)
        c.add_descriptor(stb0, 0); c.add_descriptor(ub0, 0); c.add_descriptor(dsb0, 0); c.add_descriptor(ub1, 0)
        c.add_descriptor(dsb1, 1); c.add_descriptor(stb1, 1); c.add_descriptor(ub2, 1)
        c.set_dynamic_areas([2, 1])
        c.copy1(0, 1, 1, 2); c.copy1(0, 3, 1, 2); c.copy1(1, 1, 0, 0); c.copy1(0, 2, 1, 0); c.add_result_buffer()
    case("mix_1", mix1)

    if pipeline == GRAPHICS:
        def mix2(c):
            ia0, ia1 = Descriptor(INPUT), Descriptor(INPUT)
            cs0, cs1 = Descriptor(COMBINED), Descriptor(COMBINED)
            utb0, utb1 = Descriptor(UTB, 5, 0, 5), Descriptor(UTB, 3, 1, 1)
            c.add_descriptor(cs0, 0); c.add_descriptor(ia0, 0); c.add_descriptor(utb0, 0)
            c.add_descriptor(cs1, 1); c.add_descriptor(ia1, 1); c.add_descriptor(utb1, 1)
            c.copy(0, 2, 1, 1, 2, 0, 3); c.copy1(0, 1, 1, 1); c.copy1(0, 0, 1, 0); c.add_result_buffer()
        case("mix_2", mix2)

        def mix3(c):
            iub0, iub1 = Descriptor(IUB, 4, 0, 4), Descriptor(IUB, 4, 0, 1)
            ia0, ia1 = Descriptor(INPUT), Descriptor(INPUT)
            cs0, cs1 = Descriptor(COMBINED), Descriptor(COMBINED)
            utb0, utb1 = Descriptor(UTB, 5, 0, 5), Descriptor(UTB, 3, 1, 1)
            c.add_descriptor(iub0, 0); c.add_descriptor(cs0, 0); c.add_descriptor(ia0, 0); c.add_descriptor(utb0, 0)
            c.add_descriptor(iub1, 1); c.add_descriptor(cs1, 1); c.add_descriptor(ia1, 1); c.add_descriptor(utb1, 1)
            c.copy(0, 0, 0, 1, 0, 1, 3); c.copy(0, 3, 1, 1, 3, 0, 3); c.copy1(0, 2, 1, 2); c.copy1(0, 1, 1, 1); c.add_result_buffer()
        case("mix_3", mix3)

    def mix_array0(c):
        cs0, cs1, cs2 = Descriptor(COMBINED, 3, 0, 3), Descriptor(COMBINED, 4, 0, 2), Descriptor(COMBINED, 3, 0, 3)
        si0, si1 = Descriptor(STORAGE_IMAGE, 5, 0, 5), Descriptor(STORAGE_IMAGE, 3, 0, 0)
        sb0, sb1 = Descriptor(SSBO, 2, 0, 1), Descriptor(SSBO, 3, 0, 3)
        c.add_descriptor(cs0, 0); c.add_descriptor(si0, 0); c.add_descriptor(cs1, 0); c.add_descriptor(sb0, 0); c.add_descriptor(sb1, 0)
        c.add_descriptor(si1, 1); c.add_descriptor(cs2, 1)
        c.copy(0, 0, 1, 0, 2, 2, 2); c.copy(0, 1, 2, 1, 0, 0, 3); c.copy(0, 4, 1, 0, 3, 0, 2); c.add_result_buffer()
    case("mix_array0", mix_array0)

    def mix_array1(c):
        iub0, iub1 = Descriptor(IUB, 4, 0, 1), Descriptor(IUB, 4, 0, 4)
        cs0, cs1, cs2 = Descriptor(COMBINED, 3, 0, 3), Descriptor(COMBINED, 4, 0, 2), Descriptor(COMBINED, 3, 0, 3)
        si0, si1 = Descriptor(STORAGE_IMAGE, 5, 0, 5), Descriptor(STORAGE_IMAGE, 3, 0, 0)
        sb0, sb1 = Descriptor(SSBO, 2, 0, 1), Descriptor(SSBO, 3, 0, 3)
        c.add_descriptor(iub0, 0); c.add_descriptor(cs0, 0); c.add_descriptor(si0, 0); c.add_descriptor(cs1, 0)
        c.add_descriptor(sb0, 0); c.add_descriptor(sb1, 0); c.add_descriptor(cs2, 0)
        c.add_descriptor(iub1, 1); c.add_descriptor(si1, 1)
        c.copy(1, 0, 0, 0, 0, 1, 3); c.copy(0, 1, 1, 0, 3, 2, 2); c.copy(0, 2, 2, 1, 1, 0, 3); c.copy(0, 5, 1, 0, 4, 0, 2); c.add_result_buffer()
    case("mix_array1", mix_array1)


def create_tests_for_all_descriptor_types(pipeline, uab, out):
    add_descriptor_copy_tests(UBO, "uniform_buffer", pipeline, uab, out)
    add_descriptor_copy_tests(SSBO, "storage_buffer", pipeline, uab, out)
    add_descriptor_copy_tests(COMBINED, "combined_image_sampler", pipeline, uab, out)
    add_descriptor_copy_tests(STORAGE_IMAGE, "storage_image", pipeline, uab, out)
    add_descriptor_copy_tests(UTB, "uniform_texel_buffer", pipeline, uab, out)
    add_descriptor_copy_tests(STB, "storage_texel_buffer", pipeline, uab, out)
    add_descriptor_copy_tests(IUB, "inline_uniform_block", pipeline, uab, out)
    if not uab:
        add_descriptor_copy_tests(DYN_UBO, "uniform_buffer_dynamic", pipeline, False, out)
        add_descriptor_copy_tests(DYN_SSBO, "storage_buffer_dynamic", pipeline, False, out)
        if pipeline == GRAPHICS:
            add_descriptor_copy_tests(INPUT, "input_attachment", GRAPHICS, False, out)
        add_mixed_descriptor_copy_tests(pipeline, out)
    add_sampler_copy_tests(pipeline, uab, out)
    add_sampled_image_copy_tests(pipeline, uab, out)


def all_cases():
    """Yields (group name, case name, Commands) in createDescriptorCopyTests order."""
    for group, pipeline, uab in (("compute", COMPUTE, False), ("graphics", GRAPHICS, False), ("graphics_uab", GRAPHICS, True)):
        out = []
        create_tests_for_all_descriptor_types(pipeline, uab, out)
        for name, commands in out:
            yield group, name, commands
