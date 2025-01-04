#version 450 core
out gl_PerVertex
{
  vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(float(1.0 - 2.0 * int(gl_VertexIndex != 1)) * 0.8 + 0.0,
                     float(1.0 - 2.0 * int(gl_VertexIndex > 0))  * 0.8 + 0.0, 0.0, 1.0);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(location = 0) out uvec4 outColor;
void main()
{
  outColor.x = gl_ShadingRateEXT;
  outColor.y = 0;
  outColor.z = atomicAdd(buf.counter, 1);
  outColor.w = 0;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 0);
}
#version 450 core
out gl_PerVertex
{
  vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(float(1.0 - 2.0 * int(gl_VertexIndex != 1)) * 9.0 + 0.0,
                     float(1.0 - 2.0 * int(gl_VertexIndex > 0))  * 9.0 + 0.0, 0.0, 1.0);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 0;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 1);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 1;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 2);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 2;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 4);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 4;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 5);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 5;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 6);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 6;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 8);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 8;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 9);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 9;
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(r32ui, binding = 0) coherent uniform highp uimage2D srImage;
void main (void)
{
  imageAtomicAdd(srImage, ivec2(gl_GlobalInvocationID.xy), 10);
}
#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = 10;
}
#version 450 core
out gl_PerVertex
{
  vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(float(1.0 - 2.0 * int(gl_VertexIndex != 1)) * 0.4 + -0.5,
                     float(1.0 - 2.0 * int(gl_VertexIndex > 0))  * 0.4 + -0.5, 0.0, 1.0);
}
#version 450 core
out gl_PerVertex
{
  vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(float(1.0 - 2.0 * int(gl_VertexIndex != 1)) * 0.4 + 0.5,
                     float(1.0 - 2.0 * int(gl_VertexIndex > 0))  * 0.4 + 0.5, 0.0, 1.0);
}
