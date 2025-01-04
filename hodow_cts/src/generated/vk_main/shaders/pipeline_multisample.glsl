#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
    gl_PointSize = 1.0f;
}
#version 310 es
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
    gl_PointSize = 3.0f;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock { float depth; } pc;
layout (location=0) out vec4 vtxColor;
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0, 3.0),
    vec2(3.0, -1.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], pc.depth, 1.0);
    vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
void main (void)
{
    gl_Position = position;
}
#version 440
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(fract(gl_FragCoord.xy), 0.0, 1.0);
}
#version 440
void main (void)
{
    const vec4 positions[4] = vec4[4](
        vec4(-1.0, -1.0, 0.0, 1.0),
        vec4(-1.0,  1.0, 0.0, 1.0),
        vec4( 1.0, -1.0, 0.0, 1.0),
        vec4( 1.0,  1.0, 0.0, 1.0)
    );
    gl_Position = positions[gl_VertexIndex];
}
#version 440
precision highp float;
layout(location = 0) out highp vec4 fragColor;
layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInputMS imageMS;
layout(push_constant) uniform PushConstantsBlock
{
    int sampleId;
} pushConstants;
void main (void)
{
    fragColor = subpassLoad(imageMS, pushConstants.sampleId);
}
#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
void main (void)
{
    gl_Position = position;
    gl_PointSize = 1.0f;
}
#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 color;
void main (void)
{
    gl_Position = position;
    gl_PointSize = 3.0f;
}
#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec3 fragColor1;
void main (void)
{
    fragColor0 = vtxColor;
    fragColor1 = vtxColor.rgb;
}
