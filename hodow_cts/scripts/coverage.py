#!/usr/bin/env python3
"""Report how much of the upstream CTS hodow_cts implements.

Reads the case list straight out of the binary (`--list`) and compares it against the
upstream mustpass files, so the numbers cannot drift from what actually runs. Each API
is reported separately, against its own mustpass: `dEQP-VK` against vk-default,
`dEQP-GLES31` against the AOSP gles31 mustpass.

Percentages are given against three different denominators on purpose. A single
"coverage %" would be misleading here: against the whole suite the number is
vanishingly small and always will be, while against a group that is being worked on it
is the number that says whether that group is finished. Both are true and they mean
different things.

Usage:
    python3 hodow_cts/scripts/coverage.py [--api vk|gles31] [--mustpass <dir>]
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
CTS_DIR = REPO_DIR / "tmp" / "VK-GL-CTS"
GLES_MUSTPASS_DIR = CTS_DIR / "external" / "openglcts" / "data" / "gl_cts" / "data" / "mustpass" / "gles" / "aosp_mustpass" / "main"

# Cases upstream's own test binary registers but whose mustpass leaves them out, so a
# faithful port has them and the denominator does not. Each one has to be confirmed
# against upstream's source before it is listed here - the default reading of a case we
# have and upstream does not is that the port invented a name.
MUSTPASS_OMISSIONS = {
    # glsFboCompletenessTests.cpp registers every format at every attachment point, and
    # the list has `depth.rgb16f`/`stencil.rgb16f` but not `color0.rgb16f`. Everything
    # under `shaders.` is a shader-library case: the `.test` files carry them, upstream's
    # own `deqp-gles2 --deqp-runmode=stdout-caselist` registers every one, and the AOSP
    # list simply does not name them.
    "gles2": {
        "dEQP-GLES2.functional.fbo.completeness.renderable.renderbuffer.color0.rgb16f",
        "dEQP-GLES2.functional.fbo.completeness.renderable.texture.color0.rgb16f",
        "dEQP-GLES2.functional.shaders.constant_expressions.invalid.precision_specifier",
        "dEQP-GLES2.functional.shaders.constants.const_float_function_gotcha_fragment",
        "dEQP-GLES2.functional.shaders.constants.const_float_function_gotcha_vertex",
        "dEQP-GLES2.functional.shaders.declarations.invalid_declarations.invariant_attribute",
        "dEQP-GLES2.functional.shaders.declarations.invalid_declarations.invariant_uniform",
        "dEQP-GLES2.functional.shaders.functions.invalid.array_size_from_const_arg_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.array_size_from_const_arg_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.attribute_argument_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.double_declare_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.double_declare_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.init_const_local_from_const_arg_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.init_const_local_from_const_arg_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.local_function_prototype_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.local_function_prototype_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.uniform_return_type_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.uniform_return_type_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.varying_argument_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.varying_argument_vertex",
        "dEQP-GLES2.functional.shaders.functions.invalid.varying_return_type_fragment",
        "dEQP-GLES2.functional.shaders.functions.invalid.varying_return_type_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.bvec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.false_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.false_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.ivec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.mat4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.sampler2D_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.sampler2D_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.samplerCube_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.samplerCube_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.true_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.true_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.vec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.vec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.vec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.keywords.vec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.keywords.vec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.cast_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.cast_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.double_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.double_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.dvec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.enum_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.enum_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.external_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.external_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fixed_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fixed_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.fvec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.half_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.half_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec2_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec2_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec3_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec3_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec4_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.hvec4_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.input_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.input_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.long_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.long_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.noinline_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.noinline_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.output_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.output_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.packed_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.packed_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.public_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.public_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler1DShadow_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler1DShadow_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler1D_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler1D_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DRectShadow_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DRectShadow_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DRect_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DRect_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DShadow_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler2DShadow_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler3DRect_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler3DRect_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler3D_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sampler3D_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sizeof_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.sizeof_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.union_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.union_vertex",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.using_fragment",
        "dEQP-GLES2.functional.shaders.keywords.reserved_keywords.using_vertex",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_precision_conflict_1",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_precision_conflict_2",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_precision_conflict_3",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_precision_conflict_4",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_type_conflict_1",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_type_conflict_2",
        "dEQP-GLES2.functional.shaders.linkage.uniform_struct_type_conflict_3",
        "dEQP-GLES2.functional.shaders.linkage.varying_illegal_usage_1",
        "dEQP-GLES2.functional.shaders.linkage.varying_type_mismatch_1",
        "dEQP-GLES2.functional.shaders.preprocessor.basic.identifier_with_double_underscore_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.basic.identifier_with_double_underscore_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.builtin.line_defined_1_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.builtin.line_defined_1_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.builtin.line_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.builtin.line_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.definitions.undefine_invalid_object_1_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.definitions.undefine_invalid_object_1_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.definitions.undefine_invalid_object_2_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.definitions.undefine_invalid_object_2_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.extensions.after_non_preprocessing_tokens_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.extensions.after_non_preprocessing_tokens_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.invalid_redefinitions.invalid_identifier_2_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.invalid_redefinitions.invalid_identifier_2_vertex",
        "dEQP-GLES2.functional.shaders.preprocessor.predefined_macros.line_2_fragment",
        "dEQP-GLES2.functional.shaders.preprocessor.predefined_macros.line_2_vertex",
        "dEQP-GLES2.functional.shaders.reserved_operators.operator_bitwise_not_fragment",
        "dEQP-GLES2.functional.shaders.reserved_operators.operator_bitwise_not_vertex",
        "dEQP-GLES2.functional.shaders.scoping.invalid.redeclare_function_fragment",
        "dEQP-GLES2.functional.shaders.scoping.invalid.redeclare_function_vertex",
        "dEQP-GLES2.functional.shaders.scoping.invalid.redefine_builtin_fragment",
        "dEQP-GLES2.functional.shaders.scoping.invalid.redefine_builtin_vertex",
        "dEQP-GLES2.functional.shaders.scoping.valid.local_variable_hides_function_parameter_fragment",
        "dEQP-GLES2.functional.shaders.scoping.valid.local_variable_hides_function_parameter_vertex",
        "dEQP-GLES2.functional.shaders.texture_functions.invalid.texture2d_bias_in_vertex",
        "dEQP-GLES2.functional.shaders.texture_functions.invalid.texture2dlod_in_fragment",
        "dEQP-GLES2.functional.shaders.texture_functions.invalid.texturecube_bias_in_vertex",
    },
    # Same `color0.rgb16f` gap as gles2, es3fUniformApiTests.cpp's 32 random cases with
    # one skipped, and the shader-library cases the AOSP list leaves out.
    "gles3": {
        "dEQP-GLES3.functional.fbo.completeness.renderable.renderbuffer.color0.rgb16f",
        "dEQP-GLES3.functional.fbo.completeness.renderable.texture.color0.rgb16f",
        "dEQP-GLES3.functional.shaders.arrays.invalid.empty_declaration_without_var_name_fragment",
        "dEQP-GLES3.functional.shaders.arrays.invalid.empty_declaration_without_var_name_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.other.complex_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.other.complex_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.other.nested_builtin_funcs_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.other.nested_builtin_funcs_vertex",
        "dEQP-GLES3.functional.shaders.linkage.uniform.block.layout_qualifier_mismatch_3",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.define_defined_fragment",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.define_defined_outside_if_fragment",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.define_defined_outside_if_vertex",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.define_defined_vertex",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.defined_macro_defined_test_fragment",
        "dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.defined_macro_defined_test_vertex",
        "dEQP-GLES3.functional.shaders.preprocessor.predefined_macros.line_2_fragment",
        "dEQP-GLES3.functional.shaders.preprocessor.predefined_macros.line_2_vertex",
        "dEQP-GLES3.functional.uniform_api.random.23",
        # `atanh`'s own cut: the AOSP list carries only its `lowp_vertex`/
        # `lowp_fragment`/`mediump_vertex` cases (12 of 24) plus
        # `mediump_fragment` is missing too, not `highp` either - confirmed
        # against the real `deqp-gles3` binary itself (`diff_vs_deqp.py --case
        # '*precision.atanh*'`: agree 24/24, missing 0, including every case
        # below) - it registers and passes all of them, so this is the
        # mustpass's own curated subset, not a case the port invented.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.highp_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.mediump_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.mediump_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.mediump_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atanh.mediump_fragment.vec4",
        # `acosh`'s own cut: the AOSP list carries only its `lowp`/`mediump`
        # cases (16 of 24), missing `highp_vertex`/`highp_fragment` entirely -
        # confirmed against the real `deqp-gles3` binary itself
        # (`diff_vs_deqp.py --case '*precision.acosh*'`: agree 24/24, missing
        # 0, including every case below) - same shape as `atanh` above.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acosh.highp_fragment.vec4",
        # `dot`'s own cut keeps only 9 of 24: no `highp` at all (either stage), plus
        # `lowp_vertex`/`lowp_fragment`/`mediump_vertex`/`mediump_fragment` at
        # `scalar`/`vec2` only (dropping `vec3`/`vec4` at `mediump`, and dropping
        # `lowp_vertex`/`lowp_fragment` `vec3`/`vec4` too) - confirmed against the real
        # `deqp-gles3` binary directly (`diff_vs_deqp.py --case '*precision.dot.*'`:
        # agree 24/24, missing 0, including every case below) - it registers and
        # passes all of them, so this is the mustpass's own curated subset, not a case
        # the port invented.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.highp_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.mediump_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.mediump_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.mediump_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.lowp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.lowp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.lowp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.dot.lowp_fragment.vec4",
        # `smoothstep`'s own cut is per-`GenType`, not per-precision/stage the way every
        # other function above is: the AOSP list keeps `highp_vertex`/`highp_fragment`
        # `vec2` but drops `scalar`/`vec3`/`vec4` at `highp` for both stages (18 of 24)
        # - confirmed against the real `deqp-gles3` binary directly (`diff_vs_deqp.py
        # --case '*precision.smoothstep*'`: agree 24/24, missing 0, including every
        # case below) - it registers and passes all of them.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.smoothstep.highp_fragment.vec4",
        # `reflect`'s own cut keeps only 10 of 24: drops `highp` `scalar`/`vec3`
        # entirely (both stages), `mediump` `scalar`/`vec3`/`vec4` (both stages), and
        # `lowp` `vec3`/`vec4` (both stages) - confirmed against the real `deqp-gles3`
        # binary directly (`diff_vs_deqp.py --case '*precision.reflect.*'`: agree
        # 24/24, missing 0, including every case below) - it registers and passes all
        # of them, so this is the mustpass's own curated subset, not a case the port
        # invented.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.mediump_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.lowp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.lowp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.lowp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.reflect.lowp_fragment.vec4",
        # `SquareMatrixFuncCaseFactory<Inverse>` builds all three precisions uniformly
        # (mat2-only, per upstream's own `#if 0`-disabled mat3/mat4 - see this
        # function's own doc comment in `gls::builtin_precision_tests`), but the
        # gles3-main mustpass keeps only `lowp`/`mediump`, dropping `highp` entirely
        # (both stages) - confirmed against the real `deqp-gles3` binary directly
        # (`diff_vs_deqp.py --case '*precision.inverse.*'`: agree 6/6, missing 0,
        # including both cases below) - it registers and passes them, so this is the
        # mustpass's own curated subset, not a case the port invented. `gles31-main`
        # keeps all three precisions for `inverse`, so no omission is needed there.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.inverse.highp_vertex.mat2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.inverse.highp_fragment.mat2",
        # Same `createFuncGroup`-builds-all-three-precisions-uniformly shape as
        # min/max/clamp's `gles31` entries below, but a wider cut here: the AOSP
        # gles3-main list carries only `atan2`'s `lowp_vertex`/`lowp_fragment` cases (8
        # of 24), not `mediump`/`highp` either. Confirmed against the real
        # `deqp-gles3` binary itself (`diff_vs_deqp.py --case '*precision.atan2*'`:
        # agree 24/24, missing 0, including every case below) - it registers and
        # passes all of them, so this is the mustpass's own curated subset, not a case
        # the port invented.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.highp_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan2.mediump_fragment.vec4",
        # glsShaderConstExprTests.cpp's builtin-function const-expression groups
        # (common/angle_and_trigonometry/exponential/geometric/matrix/vector_relational/
        # float_pack_unpack/fragment_processing) register every function this port
        # implements; the AOSP gles3-main list keeps only a curated subset per group
        # (e.g. `common` keeps abs/ceil/clamp/floor/max/min/round/sign/trunc but not
        # roundEven/mod/mix/step/smoothstep/isnan/isinf/floatBitsTo*). Confirmed against
        # the real `deqp-gles3` binary directly (`diff_vs_deqp.py --case
        # '*constant_expressions.builtin_functions*'`: agree 736/736, 0 differ,
        # including every case below) - it registers and passes all of them, so this is
        # the mustpass's own curated subset, not a case the port invented.
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.acosh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.asinh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_combined_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atan_separate_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.atanh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.cosh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.degrees_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.radians_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.sinh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tan_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.angle_and_trigonometry.tanh_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.floatbits_int_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.floatbits_int_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.floatbits_uint_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.floatbits_uint_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.fract_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isinf_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.isnan_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_float_bool_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_float_bool_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_bvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mix_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec2_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec2_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec3_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec3_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec4_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec4_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.mod_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.roundEven_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec2_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec2_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec3_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec3_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec4_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec4_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.smoothstep_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec2_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec2_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec3_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec3_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec4_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec4_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.common.step_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packHalf2x16_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packHalf2x16_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packSnorm2x16_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packSnorm2x16_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packUnorm2x16_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.packUnorm2x16_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.unpackSnorm2x16_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.unpackSnorm2x16_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.unpackUnorm2x16_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.float_pack_unpack.unpackUnorm2x16_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdx_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdx_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdx_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdx_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdy_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdy_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdy_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.dFdy_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.fwidth_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.fwidth_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.fwidth_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.fragment_processing.fwidth_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.distance_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.faceforward_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.reflect_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_float_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_float_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.geometric.refract_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.compMult_mat4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.determinant_mat4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.inverse_mat4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2x3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2x3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2x4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat2x4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3x2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3x2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3x4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat3x4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4x2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4x2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4x3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.outerProd_mat4x3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2x3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2x3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2x4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat2x4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3x2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3x2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3x4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat3x4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4x2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4x2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4x3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.matrix.transpose_mat4x3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.all_bvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.any_bvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_bvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.equal_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThanEqual_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.greaterThan_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThanEqual_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.lessThan_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_bvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_ivec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_uvec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.notEqual_vec4_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec2_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec2_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec3_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec3_vertex",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec4_fragment",
        "dEQP-GLES3.functional.shaders.constant_expressions.builtin_functions.vector_relational.not_bvec4_vertex",
        # dfdx/dfdy's `nicest`/`fastest`/`fbo_float`/`static_*`/`uniform_*`/`in_function`/
        # `fbo`/`linear` subgroups register more precision/control-flow/render-target
        # combinations than the AOSP list keeps (a handful per subgroup, not all of
        # them - e.g. `linear` keeps `vec4_highp` but not `vec4_lowp`/`vec4_mediump`).
        # Confirmed against the real `deqp-gles3` binary directly (`diff_vs_deqp.py
        # --case '*shaders.derivate.dfdx*'` and `*shaders.derivate.dfdy*'`: agree
        # 204/204 each, 0 differ, including every case below) - it registers and passes
        # all of them, so this is the mustpass's own curated subset, not a case the
        # port invented.
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.default.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec2_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec4_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fastest.fbo_float.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec2_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec4_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.fbo_float.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.in_function.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.linear.vec4_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.linear.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.default.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec2_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec4_lowp",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.nicest.fbo_float.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.static_if.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.static_loop.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.static_switch.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.uniform_if.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.uniform_loop.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdx.uniform_switch.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fastest.default.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fastest.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fastest.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fastest.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fastest.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fbo.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.in_function.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.linear.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.nicest.default.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.nicest.fbo_float.float_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.nicest.fbo_float.vec2_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.nicest.fbo_float.vec3_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.nicest.fbo_float.vec4_highp",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.static_if.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.static_loop.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.static_switch.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.uniform_if.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.uniform_loop.vec4_mediump",
        "dEQP-GLES3.functional.shaders.derivate.dfdy.uniform_switch.vec4_mediump",
        # Same `createFuncGroup`-builds-all-three-precisions-uniformly shape as
        # min/max/clamp/atan2's entries above and below, but a different, finer cut for
        # `atan`/`acos` than either: `atan`'s AOSP gles3-main entries are `highp_*` only
        # (no `lowp`/`mediump` at all), while `acos` keeps `highp_*`, `lowp_*` *and*
        # `mediump_fragment` - just not `mediump_vertex`. Confirmed against the real
        # `deqp-gles3` binary itself (`diff_vs_deqp.py --case '*precision.atan.*'` and
        # `'*precision.acos.*'`: agree 24/24 each, missing 0, including every case
        # below) - it registers and passes all of them, so this is the mustpass's own
        # curated subset, not a case the port invented.
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.lowp_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_fragment.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_fragment.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_fragment.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_fragment.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.atan.mediump_vertex.vec4",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acos.mediump_vertex.scalar",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acos.mediump_vertex.vec2",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acos.mediump_vertex.vec3",
        "dEQP-GLES3.functional.shaders.builtin_functions.precision.acos.mediump_vertex.vec4",
        # es3fNegativeTextureApiTests.cpp registers these two ASTC-target negative-API
        # cases; the AOSP gles3-main list doesn't carry them. Confirmed against the real
        # `deqp-gles3` binary directly (both cases individually: agree 1/1, Pass) - the
        # port didn't invent them.
        "dEQP-GLES3.functional.negative_api.texture.compressedteximage3d_invalid_astc_target",
        "dEQP-GLES3.functional.negative_api.texture.texstorage3d_invalid_astc_target",
        # es3fShaderTextureFunctionTests.cpp's `textureGradCases` table registers
        # `isamplercube`'s `GRAD_CASE_SPEC` with the `BOTH` flag (vertex and fragment),
        # same as its `usamplercube` neighbour right below it - but the AOSP gles3-main
        # list carries only the vertex half. Confirmed against the real `deqp-gles3`
        # binary directly (`diff_vs_deqp.py --case '*texturegrad.isamplercube*'`: agrees
        # 2/2, both Pass) - the port didn't invent this one either, the mustpass's own
        # curated subset just drops it.
        "dEQP-GLES3.functional.shaders.texture_functions.texturegrad.isamplercube_fragment",
        # Same shape, a different case: `textureLodOffsetCases`' `usampler2darray` entry
        # is `BOTH` (vertex and fragment) just like its `isampler2darray`/`sampler2darray_*`
        # neighbours in the same table, but the AOSP gles3-main list carries only the
        # fragment half. Confirmed against the real `deqp-gles3` binary directly
        # (`diff_vs_deqp.py --case '*texturelodoffset.usampler2darray*'`: agrees 2/2, both
        # Pass) - the mustpass's own curated subset drops the vertex half.
        "dEQP-GLES3.functional.shaders.texture_functions.texturelodoffset.usampler2darray_vertex",
        # `sampler3D`'s own `CASE_SPEC`/`GRAD_CASE_SPEC` tables register every case the
        # `sampler2D`/`sampler2DArray` siblings do (same `VERTEX`/`FRAGMENT`/`BOTH` flags
        # per row), but the AOSP gles3-main list curates `sampler3d`'s four groups more
        # asymmetrically than any other sampler kind seen so far - 16 cases across
        # `textureoffset`/`textureprojoffset`/`texturelodoffset`/`textureprojlodoffset`.
        # Confirmed against the real `deqp-gles3` binary directly, not inferred: the whole
        # `shaders.texture_functions.*` group (532 cases including these 16) reports
        # `agree: 532/532, differ: 0` via `diff_vs_deqp.py` - the port didn't invent any of
        # them, the mustpass's own curated subset just omits this many at once.
        "dEQP-GLES3.functional.shaders.texture_functions.textureoffset.isampler3d_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureoffset.isampler3d_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.textureoffset.sampler3d_fixed_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureoffset.sampler3d_float_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureoffset.usampler3d_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.texturelodoffset.sampler3d_float_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.texturelodoffset.usampler3d_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.isampler3d_bias_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.isampler3d_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.sampler3d_bias_fixed_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.sampler3d_bias_float_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.sampler3d_fixed_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.sampler3d_float_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.usampler3d_bias_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojoffset.usampler3d_fragment",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojlodoffset.isampler3d_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojlodoffset.sampler3d_float_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.textureprojlodoffset.usampler3d_vertex",
        # `sampler2darrayshadow`'s `texture` `CASE_SPEC` row is `VERTEX`, same as its
        # `FRAGMENT`-flagged sibling two lines below it in the same table, but the AOSP
        # gles3-main list carries only the fragment half here too (its own `_bias` row is
        # commented out upstream entirely - "Not in spec" - so there is no bias case to
        # omit, unlike `sampler2d`/`samplercube` shadow's own `_bias_fragment` entries,
        # which the mustpass does keep). Confirmed against the real `deqp-gles3` binary
        # directly (`diff_vs_deqp.py --case '*texture.sampler2darrayshadow*'`: agrees 2/2,
        # both Pass) - the port didn't invent this one either.
        "dEQP-GLES3.functional.shaders.texture_functions.texture.sampler2darrayshadow_vertex",
        # `textureGradCases` registers `samplercubeshadow` with the `BOTH` flag, same as its
        # `sampler2dshadow`/`sampler2darrayshadow` neighbours in the same table, but the AOSP
        # gles3-main list carries none of its `texturegrad`/`texturegradoffset` cases at all
        # (there is no `textureGradOffsetCases` entry for it upstream either, confirmed by
        # grep - the omission is total, not a vertex/fragment split like the others in this
        # set). Confirmed against the real `deqp-gles3` binary directly
        # (`diff_vs_deqp.py --case '*texturegrad.samplercubeshadow*'`: agrees 2/2, both Pass)
        # - the port didn't invent these, the mustpass's own curated subset just drops them.
        "dEQP-GLES3.functional.shaders.texture_functions.texturegrad.samplercubeshadow_vertex",
        "dEQP-GLES3.functional.shaders.texture_functions.texturegrad.samplercubeshadow_fragment",
    },
    # es31fUniformBlockTests.cpp registers 50 `all_per_block_buffers` cases (0..49) and
    # the list carries 49; es31fDebugTests.cpp registers every negative_coverage case
    # under all three reporting methods and the list carries two of the three here;
    # `empty_declaration_without_var_name` is in both arrays_of_arrays.test files, so the
    # shader library registers it per API and per `both` half and the list has none.
    "gles31": {
        "dEQP-GLES31.functional.debug.negative_coverage.get_error.state.get_framebuffer_attachment_parameteriv",
        "dEQP-GLES31.functional.debug.negative_coverage.get_error.texture.compressedteximage3d_invalid_width_height",
        "dEQP-GLES31.functional.shaders.arrays_of_arrays.es31.invalid.empty_declaration_without_var_name_fragment",
        "dEQP-GLES31.functional.shaders.arrays_of_arrays.es31.invalid.empty_declaration_without_var_name_vertex",
        "dEQP-GLES31.functional.shaders.arrays_of_arrays.es32.invalid.empty_declaration_without_var_name_fragment",
        "dEQP-GLES31.functional.shaders.arrays_of_arrays.es32.invalid.empty_declaration_without_var_name_vertex",
        "dEQP-GLES31.functional.ubo.random.all_per_block_buffers.41",
        # glsBuiltinPrecisionTests.cpp's createFuncGroup builds all three precisions
        # for every function uniformly (no per-function exception anywhere in that
        # code); the AOSP list carries only lowp/mediump for min/max's *_compute
        # cases, not highp. Confirmed against the real deqp-gles31 binary itself
        # (diff_vs_deqp.py --case '*precision.{min,max}*': agree 12/12, missing 0,
        # including the highp_compute cases below) - it registers and passes them, so
        # this is the mustpass's own curated subset, not a case the port invented.
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.min.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.min.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.min.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.min.highp_compute.vec4",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.max.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.max.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.max.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.max.highp_compute.vec4",
        # Same shape as min/max above, same real-binary confirmation.
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.clamp.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.clamp.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.clamp.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.clamp.highp_compute.vec4",
        # `atan2`'s own cut is wider than min/max/clamp's: the AOSP list carries only
        # its `lowp_compute` cases (4 of 12), not `mediump`/`highp` either - same
        # `gles3-main` shape as the `atan2` entries above, confirmed the same way
        # (`diff_vs_deqp.py --case '*precision.atan2*'` against real `deqp-gles31`:
        # agree 12/12, missing 0, including every case below).
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.highp_compute.vec4",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.mediump_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.mediump_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.mediump_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan2.mediump_compute.vec4",
        # Same shape again, for `atan`/`acos`'s own `*_compute` cases: the AOSP list
        # keeps `highp_compute` and `lowp_compute` here but not `mediump_compute`
        # (unlike `min`/`max`/`clamp` above, which omit only `highp_compute`, and
        # `atan2`, which omits `mediump_compute` *and* `highp_compute`). Confirmed
        # against the real `deqp-gles31` binary directly (`diff_vs_deqp.py --case
        # '*precision.atan.mediump_compute*'` and `'*precision.acos.mediump_compute*'`:
        # agree 4/4 each, including every case below) - it registers and passes all of
        # them, so this is the mustpass's own curated subset, not a case the port
        # invented. (The remaining 26 `gles31` unknown cases, all under
        # `multisample_interpolation.interpolate_at_centroid`, are the pre-existing,
        # already-documented `multisample_interpolation` gap every prior iteration has
        # recorded - not confirmed passing, so deliberately left out of this list.)
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan.mediump_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan.mediump_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan.mediump_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atan.mediump_compute.vec4",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acos.mediump_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acos.mediump_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acos.mediump_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acos.mediump_compute.vec4",
        # `atanh`'s own cut: the AOSP list carries only `lowp_compute`/
        # `mediump_compute` (8 of 12), not `highp_compute` - same shape as
        # min/max/clamp above, confirmed the same way (`diff_vs_deqp.py --case
        # '*precision.atanh*'` against real `deqp-gles31`: agree 12/12, missing
        # 0, including every case below).
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atanh.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atanh.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atanh.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.atanh.highp_compute.vec4",
        # Same shape as `atanh` above.
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acosh.highp_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acosh.highp_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acosh.highp_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.acosh.highp_compute.vec4",
        # `smoothstep`'s own cut here: the AOSP list drops `mediump_compute` entirely (8
        # of 12) - confirmed against the real `deqp-gles31` binary directly
        # (`diff_vs_deqp.py --case '*precision.smoothstep*'`: agree 12/12, missing 0,
        # including every case below).
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.smoothstep.mediump_compute.scalar",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.smoothstep.mediump_compute.vec2",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.smoothstep.mediump_compute.vec3",
        "dEQP-GLES31.functional.shaders.builtin_functions.precision.smoothstep.mediump_compute.vec4",
    },
}

# Where each API's mustpass lives in a checkout, and what its cases are called.
#
# The GLES tree keeps one mustpass per conformance release (3.2.2.x ... 3.2.6.x) plus
# `main`, and each release's list is a subset of the next. Only `main` is used, so the
# denominator is "the current suite" rather than the union of six historical ones -
# taking them all would count most cases six times and quietly deflate every
# percentage.
APIS = {
    "vk": {
        "prefix": "dEQP-VK.",
        "mustpass": lambda: [CTS_DIR / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"],
        "label": "upstream vk-default mustpass",
    },
    **{
        api: {
            "prefix": f"dEQP-{api.upper()}.",
            "mustpass": (lambda api: lambda: [GLES_MUSTPASS_DIR / f"{api}-main.txt"])(api),
            "label": f"upstream AOSP {api}-main mustpass",
        }
        for api in ("gles2", "gles3", "gles31")
    },
}


VULKAN_WANTED = False


def list_cases(extra: list[str]) -> list[str]:
    features = os.environ.get("HODOW_CTS_FEATURES") or ("vulkan" if VULKAN_WANTED else None)
    out = subprocess.run(
        ["cargo", "run", "-q", "-p", "hodow_cts", *(["--features", features] if features else []), "--", *extra],
        capture_output=True,
        text=True,
        cwd=REPO_DIR,
    )
    if out.returncode != 0:
        print(f"error: could not list cases:\n{out.stderr}", file=sys.stderr)
        sys.exit(1)
    return [line.strip() for line in out.stdout.splitlines() if line.strip().startswith("dEQP-")]


def upstream_cases(paths: list[Path], prefix: str) -> list[str]:
    """Every case name in the given mustpass files or directories."""
    files: list[Path] = []
    for path in paths:
        if path.is_dir():
            files.extend(sorted(path.glob("*.txt")))
        elif path.is_file():
            files.append(path)
    cases: list[str] = []
    for f in files:
        cases.extend(line.strip() for line in f.read_text().splitlines() if line.strip().startswith(prefix))
    return cases


def group_of(name: str, depth: int) -> str:
    return ".".join(name.split(".")[: depth + 1])


def pct(n: int, d: int) -> str:
    return f"{(100.0 * n / d):.4f}%" if d else "n/a"


def report(api: str, ours: list[str], stubs: set[str], theirs: list[str], label: str) -> int:
    theirs_set = set(theirs)
    omitted = MUSTPASS_OMISSIONS.get(api, set())
    unknown = [c for c in ours if c not in theirs_set and c not in omitted]
    known_omissions = [c for c in ours if c in omitted]

    matched = [c for c in ours if c in theirs_set]
    print(f"implemented and in the mustpass: {len(matched)}")
    print(f"implemented, not in the mustpass: {len(ours) - len(matched) - len(known_omissions)}  (not counted below)")
    if stubs:
        print(f"registered without an instance: {len(stubs)}  (not counted below)")
    print(f"{label}: {len(theirs)}")
    print()
    print(f"  of the whole suite:        {len(matched)}/{len(theirs)}  ({pct(len(matched), len(theirs))})")
    print(f"  still missing:             {len(theirs) - len(matched)}")

    # Per-group, at the depth of the groups actually touched, so the leaf group being
    # worked on shows up rather than being averaged away.
    ours_by_leaf: dict[str, int] = defaultdict(int)
    for c in matched:
        ours_by_leaf[group_of(c, 3)] += 1

    theirs_by_leaf: dict[str, int] = defaultdict(int)
    for c in theirs:
        theirs_by_leaf[group_of(c, 3)] += 1

    print()
    print("  per group being worked on:")
    width = max((len(g) for g in ours_by_leaf), default=0)
    for group in sorted(ours_by_leaf):
        n, d = ours_by_leaf[group], theirs_by_leaf.get(group, 0)
        print(f"    {group:<{width}}  {n}/{d}  ({pct(n, d)})")

    # The table above is built by iterating `ours`, so a group with zero implemented
    # cases never gets a row - indistinguishable from a group that was never in the
    # mustpass at all. List those separately, computed from the missing side instead.
    zero_coverage = sorted(g for g in theirs_by_leaf if g not in ours_by_leaf)
    if zero_coverage:
        print()
        print(f"  {len(zero_coverage)} group(s) with zero implemented coverage (not shown above):")
        zwidth = max(len(g) for g in zero_coverage)
        for group in zero_coverage:
            print(f"    {group:<{zwidth}}  0/{theirs_by_leaf[group]}")

    # Also show the parent groups, which is what "how far into compute are we" means.
    ours_by_top: dict[str, int] = defaultdict(int)
    for c in matched:
        ours_by_top[group_of(c, 1)] += 1
    theirs_by_top: dict[str, int] = defaultdict(int)
    for c in theirs:
        theirs_by_top[group_of(c, 1)] += 1

    print()
    print("  per top-level group:")
    width = max((len(g) for g in ours_by_top), default=0)
    for group in sorted(ours_by_top):
        n, d = ours_by_top[group], theirs_by_top.get(group, 0)
        print(f"    {group:<{width}}  {n}/{d}  ({pct(n, d)})")

    if known_omissions:
        print()
        print(f"  note: {len(known_omissions)} implemented case(s) upstream registers but its mustpass omits:")
        for c in known_omissions:
            print(f"    {c}")

    if unknown:
        print()
        print(f"  WARNING: {len(unknown)} implemented case(s) are not in the {api} mustpass:")
        for c in unknown[:10]:
            print(f"    {c}")
        print("  A name that upstream does not have cannot be compared against it.")
        return 1

    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--api", choices=[*APIS, "all"], default="all", help="which API to report on")
    ap.add_argument("--mustpass", type=Path, default=None, help="override the mustpass directory (single --api only)")
    args = ap.parse_args()

    wanted = list(APIS) if args.api == "all" else [args.api]
    global VULKAN_WANTED
    VULKAN_WANTED = "vk" in wanted
    if args.mustpass and len(wanted) != 1:
        print("error: --mustpass needs a single --api", file=sys.stderr)
        return 2

    # One `--list` for both APIs; the prefix decides which report a name lands in.
    registered = list_cases(["--list"])
    stubs = set(list_cases(["--list-stubs"]))

    status = 0
    for api in wanted:
        spec = APIS[api]
        prefix = spec["prefix"]
        paths = [args.mustpass] if args.mustpass else spec["mustpass"]()
        theirs = upstream_cases(paths, prefix)

        if len(wanted) > 1:
            print(f"=== {prefix.rstrip('.')} ===")

        if not theirs:
            where = args.mustpass or (paths[0] if paths else CTS_DIR)
            print(f"skipped: no {api} mustpass found at {where}")
            print("It comes with a VK-GL-CTS checkout; see hodow_cts/README.md.")
            print()
            continue

        # The headline number counts only cases that actually run. A registered case
        # with no instance behind it is progress, but it is not coverage, and reporting
        # the two as one figure is how a percentage stops meaning anything.
        ours = [c for c in registered if c.startswith(prefix) and c not in stubs]
        status = report(api, ours, {c for c in stubs if c.startswith(prefix)}, theirs, spec["label"]) or status
        print()

    return status


if __name__ == "__main__":
    sys.exit(main())
