#version 450
precision mediump int; precision highp float;
layout(location = 0) out vec2 v_texCoord;

void main (void)
{
  vec4 a_position = vec4(float(gl_VertexIndex & 1) * 2.0 - 1.0, float(gl_VertexIndex >> 1) * 2.0 - 1.0, 0.0, 1.0);
  v_texCoord = a_position.xy * 0.5 + 0.5;
  gl_Position = a_position;
}
#version 450
precision mediump int; precision highp float;
layout(location = 0) in vec2 v_texCoord;
layout(location = 0) out vec4 dEQP_FragColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;
void main (void)
{
  dEQP_FragColor = vec4(texture(u_sampler, v_texCoord));
}
#version 450
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout(binding = 0) uniform sampler2D u_sampler;
layout(binding = 1, rgba32f) uniform writeonly image2D u_image;
void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(u_image);
    if (pos.x < size.x && pos.y < size.y)
    {
        vec2 uv = (vec2(pos) + 0.5) / vec2(size);
        vec4 color = texture(u_sampler, uv);
        imageStore(u_image, pos, color);
    }
}
