#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) out highp vec4 v_color;
layout (set=0, binding=0) uniform PointSize {
    highp float u_pointSize;
};
void main ()
{
    gl_Position = a_position;
    gl_PointSize = u_pointSize;
    v_color = a_color;
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_color;
void main ()
{
    fragColor = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_color;
layout(location = 0) flat out highp vec4 v_color;
layout (set=0, binding=0) uniform PointSize {
    highp float u_pointSize;
};
void main ()
{
    gl_Position = a_position;
    gl_PointSize = u_pointSize;
    v_color = a_color;
}
#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) flat in highp vec4 v_color;
void main ()
{
    fragColor = v_color;
}
#version 450
layout(location = 0) in highp vec4 a_position;
void main(){
    gl_Position = a_position;
}
#version 450
layout(vertices = 1) out;
void main()
{
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
layout(isolines, point_mode) in;
void main()
{
    gl_Position = gl_in[0].gl_Position;
}
#version 450
layout(points) in;
layout(points, max_vertices=1) out;
void main()
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) out highp vec4 fragColor;
void main(){
    fragColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
