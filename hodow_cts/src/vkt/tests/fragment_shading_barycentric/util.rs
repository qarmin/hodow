// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_barycentric/vktFragmentShadingBarycentricTests.cpp
//   external/vulkancts/framework/vulkan/vkTypeUtil.hpp (primitiveTopologyCastToList and the topology predicates)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Advanced Micro Devices, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the data and the weight tests share: the parameters, the support checks, the
// render pass with an optional resolve attachment, the vertex buffer and the read back of the colour image. The read back transitions
// from COLOR_ATTACHMENT_OPTIMAL, the layout the render pass leaves the image in, where upstream's `copyImageToBuffer` default says GENERAL.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info};
use crate::vk::ref_util::Unique;
use crate::vkt::Context;
use crate::vkt::tests::mesh_shader::util::mesh_shader_features;

pub const DATA_TEST_WIDTH: u32 = 8;
pub const DATA_TEST_HEIGHT: u32 = 8;
pub const WEIGHT_TEST_WIDTH: u32 = 128;
pub const WEIGHT_TEST_HEIGHT: u32 = 128;
pub const WEIGHT_TEST_SLOPE: f32 = 16.0;

/// `TestSubtype`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TestSubtype {
    Default,
    MsaaInterpolateAtCentroid,
    MsaaInterpolateAtSample,
    MsaaInterpolateAtOffset,
    MsaaCentroidQualifier,
    MsaaSampleQualifier,
    PerVertexCorrectness,
    TessShader,
    GeometryShader,
    TessGeomShader,
}

/// The `topologies` table of `createTests`.
pub const TOPOLOGIES: [(vk::PrimitiveTopology, &str); 10] = [
    (vk::PrimitiveTopology::POINT_LIST, "point_list"),
    (vk::PrimitiveTopology::LINE_LIST, "line_list"),
    (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
    (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
    (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
    (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
    (
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        "line_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        "line_strip_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        "triangle_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        "triangle_strip_with_adjacency",
    ),
];

/// `primitiveTopologyCastToList`
pub fn primitive_topology_cast_to_list(topology: vk::PrimitiveTopology) -> vk::PrimitiveTopology {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST
        | vk::PrimitiveTopology::LINE_STRIP
        | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
        | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::TRIANGLE_LIST
        | vk::PrimitiveTopology::TRIANGLE_STRIP
        | vk::PrimitiveTopology::TRIANGLE_FAN
        | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
        | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => vk::PrimitiveTopology::TRIANGLE_LIST,
        _ => vk::PrimitiveTopology::PATCH_LIST,
    }
}

/// `isPrimitiveTopologyPoint`
pub fn is_primitive_topology_point(topology: vk::PrimitiveTopology) -> bool {
    primitive_topology_cast_to_list(topology) == vk::PrimitiveTopology::POINT_LIST
}

/// `isPrimitiveTopologyLine`
pub fn is_primitive_topology_line(topology: vk::PrimitiveTopology) -> bool {
    primitive_topology_cast_to_list(topology) == vk::PrimitiveTopology::LINE_LIST
}

/// `isPrimitiveTopologyTriangle`
pub fn is_primitive_topology_triangle(topology: vk::PrimitiveTopology) -> bool {
    primitive_topology_cast_to_list(topology) == vk::PrimitiveTopology::TRIANGLE_LIST
}

/// What `FragmentShadingBarycentricTestCase::checkSupport` asks beyond the barycentric extension itself.
#[derive(Clone, Copy, Default)]
pub struct SupportRequirements {
    pub provoking_vertex_last: bool,
    pub dynamic_topology_in_pipeline: bool,
    pub use_mesh_shader: bool,
    pub double: bool,
    pub tessellation: bool,
    pub geometry: bool,
    pub sample_rate_shading: bool,
}

/// `Context::getFragmentShaderBarycentricFeatures`
pub fn fragment_shader_barycentric_features(
    context: &Context<'_>,
) -> vk::PhysicalDeviceFragmentShaderBarycentricFeaturesKHR {
    let mut features = vk::PhysicalDeviceFragmentShaderBarycentricFeaturesKHR::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

/// `Context::getFragmentShaderBarycentricProperties`
pub fn fragment_shader_barycentric_properties(
    context: &Context<'_>,
) -> vk::PhysicalDeviceFragmentShaderBarycentricPropertiesKHR {
    let mut properties = vk::PhysicalDeviceFragmentShaderBarycentricPropertiesKHR::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

/// `FragmentShadingBarycentricTestCase::checkSupport`
pub fn check_support(context: &Context<'_>, requirements: SupportRequirements) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_fragment_shader_barycentric")?;

    if fragment_shader_barycentric_features(context).fragment_shader_barycentric == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requires VkPhysicalDeviceFragmentShaderBarycentricFeaturesKHR.fragmentShaderBarycentric".to_string(),
        ));
    }

    if requirements.provoking_vertex_last {
        context.require_device_functionality("VK_EXT_provoking_vertex")?;

        let mut provoking_vertex_features = vk::PhysicalDeviceProvokingVertexFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut provoking_vertex_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if provoking_vertex_features.provoking_vertex_last == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceProvokingVertexFeaturesEXT.provokingVertexLast".to_string(),
            ));
        }
    }

    if requirements.dynamic_topology_in_pipeline {
        context.require_device_functionality("VK_EXT_extended_dynamic_state")?;

        let mut extended_dynamic_state_features = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut extended_dynamic_state_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if extended_dynamic_state_features.extended_dynamic_state == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceExtendedDynamicStateFeaturesEXT.extendedDynamicState".to_string(),
            ));
        }
    }

    if requirements.use_mesh_shader {
        context.require_device_functionality("VK_EXT_mesh_shader")?;

        if mesh_shader_features(context).mesh_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceMeshShaderFeaturesEXT.meshShader".to_string(),
            ));
        }
    }

    if requirements.double && context.get_device_features().shader_float64 != vk::TRUE {
        return Err(TestError::NotSupported("shaderFloat64 not supported".to_string()));
    }

    if requirements.tessellation && context.get_device_features().tessellation_shader == vk::FALSE {
        return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
    }

    if requirements.geometry && context.get_device_features().geometry_shader == vk::FALSE {
        return Err(TestError::NotSupported("geometryShader not supported".to_string()));
    }

    if requirements.sample_rate_shading && context.get_device_features().sample_rate_shading == vk::FALSE {
        return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
    }

    Ok(())
}

/// `makeRenderPass` - the single sample attachment, and a multisample one resolving into it when `samples` is above one.
pub fn make_render_pass(
    device: &Device,
    format: vk::Format,
    samples: vk::SampleCountFlags,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = |samples: vk::SampleCountFlags| vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format,
        samples,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let attachments = [attachment(vk::SampleCountFlags::_1), attachment(samples)];

    let single_sample_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let multi_sample_ref = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];

    let use_multisampling = samples != vk::SampleCountFlags::_1;
    let subpass = if use_multisampling {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&multi_sample_ref)
            .resolve_attachments(&single_sample_ref)
            .build()
    } else {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&single_sample_ref)
            .build()
    };
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments[..1 + usize::from(use_multisampling)])
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `createVertexBuffer` - the vertices in a host visible buffer, read as storage by a mesh shader and as vertex input otherwise.
pub fn create_vertex_buffer<'a>(
    context: &'a Context<'a>,
    vertices: &[[f32; 4]],
    use_mesh_shader: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(vertices);
    let usage = if use_mesh_shader {
        vk::BufferUsageFlags::STORAGE_BUFFER
    } else {
        vk::BufferUsageFlags::VERTEX_BUFFER
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let bytes: Vec<u8> = vertices
        .iter()
        .flatten()
        .flat_map(|value| value.to_ne_bytes())
        .collect();
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `copyImageToBuffer` - the colour image the render pass left in COLOR_ATTACHMENT_OPTIMAL, into `buffer`, with the host barrier after it.
pub fn copy_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        range,
    );
    let region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
        device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The image `makeImageCreateInfo` describes, with memory.
pub fn make_image_create_info(
    format: vk::Format,
    width: u32,
    height: u32,
    samples: vk::SampleCountFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width,
            height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}
