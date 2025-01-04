// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/vktRenderPassGroupParams.hpp

/// `RenderingType`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum RenderingType {
    /// `RENDERING_TYPE_RENDERPASS_LEGACY`
    Legacy,
    /// `RENDERING_TYPE_RENDERPASS2`
    RenderPass2,
    /// `RENDERING_TYPE_DYNAMIC_RENDERING`
    DynamicRendering,
}

/// `GroupParams`, without `pipelineConstructionType`: every variant this port registers
/// is monolithic, and the two that are not (`graphics_pipeline_library` and the shader
/// object groups) need a pipeline-library framework the port does not have.
#[derive(Clone, Copy, PartialEq, Eq)]
pub struct GroupParams {
    pub rendering_type: RenderingType,

    /// When true a secondary command buffer is created in the test.
    pub use_secondary_cmd_buffer: bool,

    /// When true begin/endRendering is in the secondary command buffer, when false those
    /// commands are recorded to the primary command buffer. Only read when
    /// `use_secondary_cmd_buffer` is true.
    pub secondary_cmd_buffer_completely_contains_dynamic_renderpass: bool,
}
