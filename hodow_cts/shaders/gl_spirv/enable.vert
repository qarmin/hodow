#version 450

#ifdef GL_SPIRV
  layout (location = 0) in vec4 enabled;
#else
  layout (location = 0) in vec4 notEnabled;
#endif // GL_SPIRV

void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
}
