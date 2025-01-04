#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D img;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(push_constant) uniform constants {
    int pass;
} pc;
void main() {
    uvec4 color = uvec4(4160813056u, 0u, 4160813056u, 0u);
    if (pc.pass == 1)
        color = uvec4(2031647, 0u, 2031647, 0u);
    imageStore(img, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in vec2 inTexCoord;
layout(location = 1) out vec2 fragTexCoord;
void main (void) {
    gl_Position = a_position;
    fragTexCoord = inTexCoord;
}
#version 450
layout(location = 0) out vec4 outColor;
layout(location = 1) in vec2 fragTexCoord;
layout(binding = 0) uniform sampler2D compTexSampler;
void main() {
    outColor = texture(compTexSampler, fragTexCoord);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D img;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 color = uvec4(2031647, 0u, 2031647, 0u);
    imageStore(img, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
layout(location = 0) out vec4 outColor;
layout(location = 1) in vec2 fragTexCoord;
layout(binding = 0) uniform sampler2D compTexSampler;
layout(binding = 1) uniform usampler2D texSampler;
layout(push_constant) uniform constants {
    int pass;
} pc;
void main() {
    if (pc.pass == 1)
        outColor = texture(compTexSampler, fragTexCoord);
    else        outColor = texture(texSampler, fragTexCoord);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D img;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(push_constant) uniform constants {
    int pass;
} pc;
void main() {
    uvec4 color = uvec4(4294967295u, 4294967295u, 4160813056u, 0u);
    if (pc.pass == 1)
        color = uvec4(4294967295u, 4294967295u, 2031647, 0u);
    imageStore(img, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
layout(set = 0, binding = 0, rgba32ui) uniform highp uimage2D img;
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
    uvec4 color = uvec4(4294967295u, 4294967295u, 2031647, 0u);
    imageStore(img, ivec2(gl_GlobalInvocationID.xy), color);
}
