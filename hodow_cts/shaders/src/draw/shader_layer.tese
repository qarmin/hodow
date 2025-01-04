#version 450
#extension GL_ARB_shader_viewport_layer_array : require

layout(triangles, equal_spacing, cw) in;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_Layer = gl_PrimitiveID / 2;
    gl_Position = gl_in[0].gl_Position * gl_TessCoord.x +
                  gl_in[1].gl_Position * gl_TessCoord.y +
                  gl_in[2].gl_Position * gl_TessCoord.z;

    out_color = in_color[0] * gl_TessCoord.x +
                in_color[1] * gl_TessCoord.y +
                in_color[2] * gl_TessCoord.z;
}
