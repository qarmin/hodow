// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fLightAmountTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader sources stay upstream's
// `tcu::StringTemplate` text verbatim, substituted at run time - the driver's own GLSL
// compiler is what this case exercises.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::tcu::{StringTemplate, TestOutcome, TestStatus};

const S_NO_LIGHTS_VERTEX_SHADER: &str = concat!(
    "uniform mat4 u_modelviewMatrix;\n",
    "uniform mat4 u_modelviewProjectionMatrix;\n",
    "uniform mat3 u_normalMatrix;\n",
    "\n",
    "attribute vec4 a_position;\n",
    "attribute vec3 a_normal;\n",
    "\n",
    "varying vec3 v_color;\n",
    "\n",
    "void main()\n",
    "{\n",
    "    v_color = vec3(0.0);\n",
    "    gl_Position = u_modelviewProjectionMatrix * a_position;\n",
    "}\n",
);

const S_VERTEX_SHADER_TEMPLATE: &str = concat!(
    "struct Light\n",
    "{\n",
    "    vec3    position;\n",
    "    vec3    diffuse;\n",
    "    vec3    specular;\n",
    "    vec3    attenuation;\n",
    "};\n",
    "uniform Light u_lights[${NUM_DIR_LIGHTS} + ${NUM_OMNI_LIGHTS}];\n",
    "uniform mat4 u_modelviewMatrix;\n",
    "uniform mat4 u_modelviewProjectionMatrix;\n",
    "uniform mat3 u_normalMatrix;\n",
    "\n",
    "attribute vec4 a_position;\n",
    "attribute vec3 a_normal;\n",
    "\n",
    "varying vec3 v_color;\n",
    "\n",
    "float computeAttenuation(vec3 dirToLight, vec3 attenuation)\n",
    "{\n",
    "    float dist = length(dirToLight);\n",
    "    return 1.0 / (attenuation.x + attenuation.y*dist + attenuation.z*dist*dist);\n",
    "}\n",
    "\n",
    "vec3 computeDirLight(int ndx, vec3 position, vec3 normal)\n",
    "{\n",
    "    Light light = u_lights[ndx];\n",
    "    float cosAngle = dot(light.position, normal);\n",
    "    return cosAngle * light.diffuse;\n",
    "}\n",
    "\n",
    "vec3 computeOmniLight(int ndx, vec3 position, vec3 normal)\n",
    "{\n",
    "    Light light = u_lights[ndx];\n",
    "    vec3 dirToLight = light.position - position;\n",
    "    float cosAngle = dot(normalize(dirToLight), normal);\n",
    "    float atten = computeAttenuation(dirToLight, light.attenuation);\n",
    "    return atten * cosAngle * light.diffuse;\n",
    "}\n",
    "\n",
    "void main()\n",
    "{\n",
    "    vec3 lightSpacePos = vec3(u_modelviewMatrix * a_position);\n",
    "    vec3 lightNormal = normalize(u_normalMatrix * a_normal);\n",
    "    vec3 color = vec3(0.0);\n",
    "    for (int i = 0; i < ${NUM_DIR_LIGHTS}; i++)\n",
    "        color += computeDirLight(i, lightSpacePos, lightNormal);\n",
    "    for (int i = 0; i < ${NUM_OMNI_LIGHTS}; i++)\n",
    "        color += computeOmniLight(${NUM_DIR_LIGHTS}+i, lightSpacePos, lightNormal);\n",
    "    v_color = color;\n",
    "    gl_Position = u_modelviewProjectionMatrix * a_position;\n",
    "}\n",
);

const S_FRAGMENT_SHADER_TEMPLATE: &str = concat!(
    "varying highp vec3 v_color;\n",
    "\n",
    "void main()\n",
    "{\n",
    "    gl_FragColor = vec4(v_color, 1.0);\n",
    "}\n",
);

#[derive(Clone, Copy)]
struct LightAmountCase {
    name: &'static str,
    num_directional_lights: i32,
    num_omni_lights: i32,
    num_spot_lights: i32,
}

impl TestCase for LightAmountCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        glu::expect_no_error(gl, "LightAmountTest::iterate() begin")?;

        let vertex_shader_source;
        let fragment_shader_source;

        // Fill in shader template parameters.
        {
            let has_any_lights = (self.num_directional_lights + self.num_omni_lights + self.num_spot_lights) != 0;

            let vertex_template = StringTemplate::new(if has_any_lights {
                S_VERTEX_SHADER_TEMPLATE
            } else {
                S_NO_LIGHTS_VERTEX_SHADER
            });
            let fragment_template = StringTemplate::new(S_FRAGMENT_SHADER_TEMPLATE);

            let params = [
                ("NUM_DIR_LIGHTS", self.num_directional_lights.to_string()),
                ("NUM_OMNI_LIGHTS", self.num_omni_lights.to_string()),
                ("NUM_SPOT_LIGHTS", self.num_spot_lights.to_string()),
            ];

            vertex_shader_source = vertex_template.specialize(&params)?;
            fragment_shader_source = fragment_template.specialize(&params)?;
        }

        // Create shader and program objects.
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(vertex_shader_source, fragment_shader_source),
        );

        // Draw something? Check results?
        // SAFETY: the program name is this case's own; after a failed link it is still a
        // valid name, and GL answers with GL_INVALID_OPERATION rather than misbehaving.
        unsafe { gl.use_program(program.program()) };

        let test_ok = program.is_ok();

        // Upstream's trailing `GLU_CHECK_MSG` would trip on the GL_INVALID_OPERATION a
        // failed `useProgram` leaves behind, turning a Fail into an internal error.
        glu::drain_errors(gl);

        Ok(if test_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `LightAmountTest::init`
pub fn create_tests() -> TestCaseGroup {
    //                                              name    dir, omni, spot
    #[rustfmt::skip]
    const CASES: &[LightAmountCase] = &[
        LightAmountCase { name: "none",   num_directional_lights: 0,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "1dir",   num_directional_lights: 1,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "2dir",   num_directional_lights: 2,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "4dir",   num_directional_lights: 4,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "6dir",   num_directional_lights: 6,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "8dir",   num_directional_lights: 8,  num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "10dir",  num_directional_lights: 10, num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "12dir",  num_directional_lights: 12, num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "14dir",  num_directional_lights: 14, num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "16dir",  num_directional_lights: 16, num_omni_lights: 0,  num_spot_lights: 0 },
        LightAmountCase { name: "1omni",  num_directional_lights: 0,  num_omni_lights: 1,  num_spot_lights: 0 },
        LightAmountCase { name: "2omni",  num_directional_lights: 0,  num_omni_lights: 2,  num_spot_lights: 0 },
        LightAmountCase { name: "4omni",  num_directional_lights: 0,  num_omni_lights: 4,  num_spot_lights: 0 },
        LightAmountCase { name: "6omni",  num_directional_lights: 0,  num_omni_lights: 6,  num_spot_lights: 0 },
        LightAmountCase { name: "8omni",  num_directional_lights: 0,  num_omni_lights: 8,  num_spot_lights: 0 },
        LightAmountCase { name: "10omni", num_directional_lights: 0,  num_omni_lights: 10, num_spot_lights: 0 },
        LightAmountCase { name: "12omni", num_directional_lights: 0,  num_omni_lights: 12, num_spot_lights: 0 },
        LightAmountCase { name: "14omni", num_directional_lights: 0,  num_omni_lights: 14, num_spot_lights: 0 },
        LightAmountCase { name: "16omni", num_directional_lights: 0,  num_omni_lights: 16, num_spot_lights: 0 },
        // The spot-light and mixed-light cases are commented out upstream too.
    ];

    let mut group = TestCaseGroup::new("light_amount");
    for case in CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
    group
}
