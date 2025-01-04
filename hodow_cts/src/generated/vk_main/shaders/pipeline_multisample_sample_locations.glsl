#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std430) readonly buffer SampleData {
    uvec2 renderSize;
    uvec2 gridSize;
    uint  samplesPerPixel;
          // padding 1-uint size;
    vec2  data[];
} sb_data;

void main(void)
{
    uvec2 fragCoord = uvec2(gl_FragCoord.xy);
    uint  index     = (fragCoord.y * sb_data.renderSize.x + fragCoord.x) * sb_data.samplesPerPixel + gl_SampleID;

    if (gl_PrimitiveID == index)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 o_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_position  = in_position.xy;
}
#version 450

layout(location = 0) sample in  vec2 in_value;
layout(location = 0)        out vec4 o_color;

layout(set = 0, binding = 0, std430) readonly buffer SampleData {
    uvec2 renderSize;
    uvec2 gridSize;
    uint  samplesPerPixel;
          // padding 1-uint size;
    vec2  data[];
} sb_data;

void main(void)
{
    uvec2 fragCoord         = uvec2(gl_FragCoord.xy);
    uint  index             = (fragCoord.y * sb_data.renderSize.x + fragCoord.x) * sb_data.samplesPerPixel + gl_SampleID;
    vec2  diff              = abs(sb_data.data[index] - in_value);
    vec2  threshold         = vec2(0.002);

    if (all(lessThan(diff, threshold)))
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_color     = in_color;

    // We use instance index to draw the left shape (index = 0) or the right shape (index = 1).
    // Vertices are squished and moved to either half of the viewport.
    if (gl_InstanceIndex == 0)
        gl_Position.x = 0.5 * (gl_Position.x - 1.0);
    else if (gl_InstanceIndex == 1)
        gl_Position.x = 0.5 * (gl_Position.x + 1.0);
}
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = in_color;
}
