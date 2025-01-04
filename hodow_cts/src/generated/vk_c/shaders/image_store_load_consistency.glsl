#version 450
layout (local_size_x = 1) in;
layout (binding = 0, rgba32f) uniform image1D imageSrc;
layout (binding = 1, rgba32f) writeonly uniform image1D imageDst;
void main ()
{
  ivec3 coord = ivec3(gl_GlobalInvocationID.xyz);
  int checker = (coord.x / 2 + coord.y / 2 + coord.z / 2) % 2;
  vec4  fcolor = vec4(float(checker), 0.0, float(checker == 0), 1.0);
  ivec4 icolor = ivec4(255 * int(checker), 0, 255 * int(checker == 0), 255);
  imageStore(imageSrc, coord.x, fcolor);
  imageStore(imageDst, coord.x, imageLoad(imageSrc, coord.x));
}
#version 450
layout (local_size_x = 1) in;
layout (binding = 0, r32i) uniform iimage2D imageSrc;
layout (binding = 1, r32i) writeonly uniform iimage2D imageDst;
void main ()
{
  ivec3 coord = ivec3(gl_GlobalInvocationID.xyz);
  int checker = (coord.x / 2 + coord.y / 2 + coord.z / 2) % 2;
  vec4  fcolor = vec4(float(checker), 0.0, float(checker == 0), 1.0);
  ivec4 icolor = ivec4(255 * int(checker), 0, 255 * int(checker == 0), 255);
  imageStore(imageSrc, coord.xy, icolor);
  imageStore(imageDst, coord.xy, imageLoad(imageSrc, coord.xy));
}
#version 450
layout (local_size_x = 1) in;
layout (binding = 0, rgba8) uniform image3D imageSrc;
layout (binding = 1, rgba8) writeonly uniform image3D imageDst;
void main ()
{
  ivec3 coord = ivec3(gl_GlobalInvocationID.xyz);
  int checker = (coord.x / 2 + coord.y / 2 + coord.z / 2) % 2;
  vec4  fcolor = vec4(float(checker), 0.0, float(checker == 0), 1.0);
  ivec4 icolor = ivec4(255 * int(checker), 0, 255 * int(checker == 0), 255);
  imageStore(imageSrc, coord.xyz, fcolor);
  imageStore(imageDst, coord.xyz, imageLoad(imageSrc, coord.xyz));
}
