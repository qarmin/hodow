#version 450 core
layout(location = 0) out uint outColor;
void main()
{
  outColor.x = ${rate_value};
}
