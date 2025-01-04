#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_Position = in_position;
    out_color = in_color;
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = in_color;
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_Position = in_position;
    out_color = in_color + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = in_color + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
}
#version 450
#extension GL_EXT_multiview : enable
layout(triangles) in;
layout(triangle_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0] + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    out_color = in_color[0] + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    out_color = in_color[0] + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
    out_color = in_color[0] + vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
    gl_Position = vec4(gl_in[2].gl_Position.x, gl_in[1].gl_Position.y, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_multiview : enable
#extension GL_EXT_tessellation_shader : require
layout(vertices = 4) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if ( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = 4.0f;
        gl_TessLevelInner[1] = 4.0f;
        gl_TessLevelOuter[0] = 4.0f;
        gl_TessLevelOuter[1] = 4.0f;
        gl_TessLevelOuter[2] = 4.0f;
        gl_TessLevelOuter[3] = 4.0f;
    }
    out_color[gl_InvocationID] = in_color[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_multiview : enable
#extension GL_EXT_tessellation_shader : require
layout( quads, equal_spacing, ccw ) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position +(1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;
    out_color = in_color[0]+ vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput in_color_attachment;
void main()
{
    out_color = vec4(subpassLoad(in_color_attachment));
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    int modInstance = gl_InstanceIndex % 4;
    int instance    = gl_InstanceIndex + 1;
    gl_Position = in_position;
    if (modInstance == 1)
        gl_Position = in_position + vec4(0.0f, 1.0f, 0.0f, 0.0f);
    if (modInstance == 2)
        gl_Position = in_position + vec4(1.0f, 0.0f, 0.0f, 0.0f);
    if (modInstance == 3)
        gl_Position =  in_position + vec4(1.0f, 1.0f, 0.0f, 0.0f);
    out_color = in_color + vec4(0.0f, gl_ViewIndex * 0.10f, instance * 0.10f, 0.0f);
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    int instance = gl_InstanceIndex + 1;
    gl_Position = in_position;
    if (gl_VertexIndex == 1)
        gl_Position.y += 1.0f;
    else if (gl_VertexIndex == 2)
        gl_Position.x += 1.0f;
    else if (gl_VertexIndex == 3)
    {
        gl_Position.x += 1.0f;
        gl_Position.y += 1.0f;
    }
    out_color = in_color + vec4(0.0f, gl_ViewIndex * 0.10f, instance * 0.10f, 0.0f);
}
#version 450
#extension GL_EXT_multiview : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 1) in highp vec4 in_color;
layout(location = 0) out vec4 out_color;
void main (void)
{
    gl_Position = in_position;
    if (gl_ViewIndex == 0)
        gl_PointSize = 4.0f;
    else
        gl_PointSize = 2.0f;
    out_color = in_color;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  3.0),
    vec2( 3.0, -1.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 1.0, 1.0);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color = uvec4(layerIndex, 255, 0, 255);
}
