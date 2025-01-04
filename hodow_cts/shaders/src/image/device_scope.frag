#version 450
#pragma use_vulkan_memory_model
#extension GL_KHR_memory_scope_semantics : enable
layout (binding = 1, ${qualifier}) readonly uniform ${image_type} u_image0;
layout (location=0) out ${color_type} outcolor;

void main (void)
{
    memoryBarrier(gl_ScopeDevice, gl_StorageSemanticsImage, gl_SemanticsAcquireRelease | gl_SemanticsMakeVisible);
${frag_body}}
