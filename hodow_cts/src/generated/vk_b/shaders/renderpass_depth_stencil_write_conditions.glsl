#version 450
layout(location = 0) in highp vec4 a_position;
void main (void) {
    gl_Position = a_position;
}
#version 450



layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        discard;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragDepth = 0.2;
}
#version 450



layout(location = 0) out vec4 outColor;
void main() {
    gl_FragDepth = 0.2;
    if (int(gl_FragCoord.x) % 2 == 0)
        discard;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
#version 450


#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        discard;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragStencilRefARB = 1;
}
#version 450


#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {
    gl_FragStencilRefARB = 1;
    if (int(gl_FragCoord.x) % 2 == 0)
        discard;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
#version 450
#extension GL_EXT_terminate_invocation : require


layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        terminateInvocation;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragDepth = 0.2;
}
#version 450
#extension GL_EXT_terminate_invocation : require


layout(location = 0) out vec4 outColor;
void main() {
    gl_FragDepth = 0.2;
    if (int(gl_FragCoord.x) % 2 == 0)
        terminateInvocation;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
#version 450
#extension GL_EXT_terminate_invocation : require

#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        terminateInvocation;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragStencilRefARB = 1;
}
#version 450
#extension GL_EXT_terminate_invocation : require

#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {
    gl_FragStencilRefARB = 1;
    if (int(gl_FragCoord.x) % 2 == 0)
        terminateInvocation;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
#version 450

#extension GL_EXT_demote_to_helper_invocation : require

layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        demote;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragDepth = 0.2;
}
#version 450

#extension GL_EXT_demote_to_helper_invocation : require

layout(location = 0) out vec4 outColor;
void main() {
    gl_FragDepth = 0.2;
    if (int(gl_FragCoord.x) % 2 == 0)
        demote;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
#version 450

#extension GL_EXT_demote_to_helper_invocation : require
#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {

    if (int(gl_FragCoord.x) % 2 == 0)
        demote;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
    gl_FragStencilRefARB = 1;
}
#version 450

#extension GL_EXT_demote_to_helper_invocation : require
#extension GL_ARB_shader_stencil_export : require
layout(location = 0) out vec4 outColor;
void main() {
    gl_FragStencilRefARB = 1;
    if (int(gl_FragCoord.x) % 2 == 0)
        demote;
    outColor = vec4(1.0, 1.0, 1.0, 1.0);

}
