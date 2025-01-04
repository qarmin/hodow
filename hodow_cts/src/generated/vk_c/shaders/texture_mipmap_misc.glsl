#version 450
layout(location = 0) in vec4 a_position;
layout(location = 1) in vec3 a_texCoord;
layout(location = 0) out vec3 v_texCoord;
out gl_PerVertex { vec4 gl_Position; };

void main (void)
{
    gl_Position = a_position;
    v_texCoord = a_texCoord;
}
#version 450
layout(location = 0) in vec3 v_texCoord;
layout(location = 0) out vec4 dEQP_FragColor;
layout (set=0, binding=0, std140) uniform Block 
{
  float u_bias;
  float u_ref;
  vec4 u_colorScale;
  vec4 u_derivatives;
};

layout (set=1, binding=0) uniform samplerCube u_sampler;
void main (void)
{
  vec3 dx = u_derivatives.xyz * (1.0 - u_derivatives.w);
  vec3 dy = u_derivatives.xyz * u_derivatives.w;
  dEQP_FragColor = textureGrad(u_sampler, v_texCoord, dx, dy);
}
