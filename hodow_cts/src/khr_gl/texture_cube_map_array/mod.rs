// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayTests.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only (the ETC2 case is registered for a core context, as upstream does).
//
// Ported so far: color_depth_attachments, stencil_attachments_*, tex3D_validation, subimage3D, getter_calls, generate_mip_map_*, image_op_*, fbo_incompleteness, texture_size_*, etc2_texture (a core context, as upstream's condition has it), sampling. Every case of the group is ported.

mod color_depth_attachments;
mod etc2_support;
mod fbo_incompleteness;
mod generate_mip_map;
mod getter_calls;
mod image_operations;
mod image_texture_size;
mod sampling;
mod stencil_attachments;
mod subimage3d;
mod tex3d_validation;

use super::esext::ExtParameters;
use crate::glu::TestCaseGroup;

/// `STORAGE_TYPE`
#[derive(Clone, Copy, PartialEq, Eq)]
enum StorageType {
    Mutable,
    Immutable,
}

/// `TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED`
const TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED: &str =
    "Texture cube map array functionality not supported, skipping";

/// `TextureCubeMapArrayTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    use crate::glu::TestCase;

    let mut group = TestCaseGroup::new("texture_cube_map_array");
    group.add_child(Box::new(color_depth_attachments::ColorDepthAttachments { ext_params }) as Box<dyn TestCase>);
    for (name, immutable_storage, fbo_layered) in [
        ("stencil_attachments_mutable_nonlayered", false, false),
        ("stencil_attachments_mutable_layered", false, true),
        ("stencil_attachments_immutable_nonlayered", true, false),
        ("stencil_attachments_immutable_layered", true, true),
    ] {
        group.add_child(Box::new(stencil_attachments::StencilAttachments {
            name,
            ext_params,
            immutable_storage,
            fbo_layered,
        }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(tex3d_validation::Tex3DValidation { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(subimage3d::SubImage3D { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(getter_calls::GetterCalls { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(generate_mip_map::Filterable {
        name: "generate_mip_map_filterable_internalformat_mutable",
        ext_params,
        storage_type: StorageType::Mutable,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(generate_mip_map::Filterable {
        name: "generate_mip_map_filterable_internalformat_immutable",
        ext_params,
        storage_type: StorageType::Immutable,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(generate_mip_map::NonFilterable {
        name: "generate_mip_map_non_filterable_mutable_storage",
        ext_params,
        storage_type: StorageType::Mutable,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(generate_mip_map::NonFilterable {
        name: "generate_mip_map_non_filterable_immutable_storage",
        ext_params,
        storage_type: StorageType::Immutable,
    }) as Box<dyn TestCase>);
    for (name, shader_to_check) in [
        ("image_op_compute_sh", image_operations::ShaderToCheck::Compute),
        ("image_op_vertex_sh", image_operations::ShaderToCheck::Vertex),
        ("image_op_fragment_sh", image_operations::ShaderToCheck::Fragment),
        ("image_op_geometry_sh", image_operations::ShaderToCheck::Geometry),
        (
            "image_op_tessellation_control_sh",
            image_operations::ShaderToCheck::TessellationControl,
        ),
        (
            "image_op_tessellation_evaluation_sh",
            image_operations::ShaderToCheck::TessellationEvaluation,
        ),
    ] {
        group.add_child(Box::new(image_operations::ImageOp {
            name,
            ext_params,
            shader_to_check,
        }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(fbo_incompleteness::FboIncompleteness { ext_params }) as Box<dyn TestCase>);
    for (name, kind) in [
        ("texture_size_vertex_sh", image_texture_size::Kind::TfVertex),
        ("texture_size_geometry_sh", image_texture_size::Kind::TfGeometry),
        (
            "texture_size_tesselation_con_sh",
            image_texture_size::Kind::TfTessControl,
        ),
        (
            "texture_size_tesselation_ev_sh",
            image_texture_size::Kind::TfTessEvaluation,
        ),
        ("texture_size_fragment_sh", image_texture_size::Kind::RtFragment),
        ("texture_size_compute_sh", image_texture_size::Kind::RtCompute),
    ] {
        group.add_child(Box::new(image_texture_size::ImageTextureSize { name, ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(sampling::Sampling { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(etc2_support::Etc2Support) as Box<dyn TestCase>);
    group
}
