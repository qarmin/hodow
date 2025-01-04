#version 310 es
precision highp float;
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color0;
layout(location = 2) in vec4 in_color1;
layout(location = 0) out vec4 out_color;
bool is_valid(vec4 color)
{
  return
    (color.r - 0.25000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.75000 < 0.00001 && color.a - 1.00000 < 0.00001) ||
    (color.r - 0.75000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.25000 < 0.00001 && color.a - 1.00000 < 0.00001);
}
bool is_invalid(vec4 color)
{
  return
    (color.r - 0.25000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.75000 < 0.00001 && color.a - 1.00000 < 0.00001) ||
    (color.r - 0.75000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.25000 < 0.00001 && color.a - 1.00000 < 0.00001) ||
    (color.r - 0.00000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.00000 < 0.00001 && color.a - 0.00000 < 0.00001) ||
    (color.r - 0.00000 < 0.00001 && color.g - 0.00000 < 0.00001 && color.b - 0.00000 < 0.00001 && color.a - 1.00000 < 0.00001);
}
bool validate(bool should_be_valid, vec4 color0, vec4 color1)
{
  return (should_be_valid && is_valid(color0) && is_valid(color1)) || (is_invalid(color0) && is_invalid(color1));
}
void main()
{
  out_color = validate(in_position.z >= 1.0, in_color0, in_color1) ? vec4(0,1,0,1) : in_color0;  gl_Position = vec4(in_position.xy, 0.0, 1.0);
}
#version 310 es
precision highp float;
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main() {
  out_color = in_color;
}
