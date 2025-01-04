#version 450
${'#extension GL_EXT_terminate_invocation : require' if discard_kind == 1 else ''}
${'#extension GL_EXT_demote_to_helper_invocation : require' if discard_kind == 2 else ''}
${'#extension GL_ARB_shader_stencil_export : require' if stencil else ''}
layout(location = 0) out vec4 outColor;
void main() {
${('    gl_FragStencilRefARB = 1;' if stencil else '    gl_FragDepth = 0.2;') if init_only else ''}
    if (int(gl_FragCoord.x) % 2 == 0)
        ${'discard;' if discard_kind == 0 else ('terminateInvocation;' if discard_kind == 1 else 'demote;')}
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
${'' if init_only else ('    gl_FragStencilRefARB = 1;' if stencil else '    gl_FragDepth = 0.2;')}
}
