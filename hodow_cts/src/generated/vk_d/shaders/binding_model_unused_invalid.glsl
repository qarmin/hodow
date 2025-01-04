#version 450
layout(push_constant) uniform PushConstants 
{
    uint index;
} pc;
layout(set = 0, binding = 0, rgba32f) writeonly uniform image2D o_color;
layout(set = 0, binding = 1) uniform UniformBuffer{
	vec4 data;
} u_buffer[2];
layout(set = 0, binding = 2) uniform sampler u_sampler;
void main()
{
    uint ndx = pc.index;
	vec4 color0 = u_buffer[ndx + 0].data;
	vec4 color1 = u_buffer[ndx + 1].data;
    vec4 color = color0 + color1;
    imageStore(o_color, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y), color);
}
#version 450
layout(push_constant) uniform PushConstants 
{
    uint index;
} pc;
layout(set = 0, binding = 0, rgba32f) writeonly uniform image2D o_color;
layout(set = 0, binding = 1) buffer StorageBuffer{
	vec4 data;
} u_buffer[2];
layout(set = 0, binding = 2) uniform sampler u_sampler;
void main()
{
    uint ndx = pc.index;
	vec4 color0 = u_buffer[ndx + 0].data;
	vec4 color1 = u_buffer[ndx + 1].data;
    vec4 color = color0 + color1;
    imageStore(o_color, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y), color);
}
#version 450
layout(push_constant) uniform PushConstants 
{
    uint index;
} pc;
layout(set = 0, binding = 0, rgba32f) writeonly uniform image2D o_color;
layout(set = 0, binding = 1) uniform texture2D u_textures[2];
layout(set = 0, binding = 2) uniform sampler u_sampler;
void main()
{
    uint ndx = pc.index;
	vec4 color0 = texture(sampler2D(u_textures[ndx + 0], u_sampler), ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
	vec4 color1 = texture(sampler2D(u_textures[ndx + 1], u_sampler), ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
    vec4 color = color0 + color1;
    imageStore(o_color, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y), color);
}
#version 450
layout(push_constant) uniform PushConstants 
{
    uint index;
} pc;
layout(set = 0, binding = 0, rgba32f) writeonly uniform image2D o_color;
layout(set = 0, binding = 1) uniform sampler2D u_textures[2];
layout(set = 0, binding = 2) uniform sampler u_sampler;
void main()
{
    uint ndx = pc.index;
	vec4 color0 = texture(u_textures[ndx + 0], ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
	vec4 color1 = texture(u_textures[ndx + 1], ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
    vec4 color = color0 + color1;
    imageStore(o_color, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y), color);
}
#version 450
layout(push_constant) uniform PushConstants 
{
    uint index;
} pc;
layout(set = 0, binding = 0, rgba32f) writeonly uniform image2D o_color;
layout(set = 0, binding = 1, rgba32f) uniform image2D u_textures[2];
layout(set = 0, binding = 2) uniform sampler u_sampler;
void main()
{
    uint ndx = pc.index;
	vec4 color0 = imageLoad(u_textures[ndx + 0], ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
	vec4 color1 = imageLoad(u_textures[ndx + 1], ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y));
    vec4 color = color0 + color1;
    imageStore(o_color, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y), color);
}
