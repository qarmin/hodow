#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) out highp vec4 in_f_color;

void main (void)
{
    highp vec2 xy = gl_TessCoord.x * gl_in[0].gl_Position.xy
                  + gl_TessCoord.y * gl_in[1].gl_Position.xy
                  + gl_TessCoord.z * gl_in[2].gl_Position.xy;
    gl_Position = vec4(xy, 0.0, 1.0);
    in_f_color = vec4(gl_in[0].gl_Position.z + gl_in[1].gl_Position.w,
                      gl_in[2].gl_Position.z + gl_in[0].gl_Position.w,
                      gl_in[1].gl_Position.z + gl_in[2].gl_Position.w,
                      1.0);
}
