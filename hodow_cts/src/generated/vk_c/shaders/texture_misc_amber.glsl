#version 430
layout(local_size_x=10, local_size_y=10) in;
uniform layout (set=0, binding=0, r11f_g11f_b10f) image2D texture;

void main ()
{
    ivec2 uv = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = vec4(uv.x - uv.y, uv.y, -uv.y, 1);
    imageStore(texture, uv, color);
}
#version 430
layout(local_size_x=1, local_size_y=1) in;
uniform layout (set=0, binding=0, r11f_g11f_b10f) image2D texture;
layout(binding = 1) buffer Buf1
{
    int result;
};

void main ()
{
  result = 1;

  for (int y = 0; y < 50; y++)
      for (int x = 0; x < 50; x++)
      {
          ivec2 uv = ivec2(x, y);
          vec4 color = imageLoad(texture, uv);
          // Conversion to tiny float should clamp negative values to zero,
          // thus the max operation here.
          vec4 ref = max(vec4(uv.x - uv.y, uv.y, -uv.y, 1), vec4(0));

          if (color != ref)
              result = 0;
      }
}
#version 430
layout(location = 0) in vec4 position;
void main() {
  gl_Position = position;
}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) sampler2DShadow tex;
void main()
{
    // Sample border color of opaque white which makes the depth comparison 0.5 > 1.0 false.
    color_out = vec4(texture(tex, vec3(2.0, 2.0, 0.5)), 0.0, 0.0, 1.0);
}
