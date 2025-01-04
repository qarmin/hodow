#version 450
layout (location = 0) in vec2 texCoord;
layout (location = 0) out vec4 out_color0;
layout (location = 1) out vec4 out_color1;
layout (location = 2) out vec4 out_color2;
layout (location = 3) out vec4 out_color3;
void main()
{
    out_color0 = vec4(texCoord, 0.0f, 1.0f);
    out_color1 = vec4(texCoord, 0.0f, 1.0f);
    out_color2 = vec4(texCoord, 0.0f, 1.0f);
    out_color3 = vec4(texCoord, 0.0f, 1.0f);
}
