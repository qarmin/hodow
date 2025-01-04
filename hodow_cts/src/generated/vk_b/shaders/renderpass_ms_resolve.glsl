#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void) {
	gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
	                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
highp float;

layout(triangles) in;
layout(triangle_strip, max_vertices = 18) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void) {
    for (int layerNdx = 0; layerNdx < 3; ++layerNdx) {
        for(int vertexNdx = 0; vertexNdx < gl_in.length(); vertexNdx++) {
            gl_Position = gl_in[vertexNdx].gl_Position;
            gl_Layer    = layerNdx;
            EmitVertex();
        };
        EndPrimitive();
    };
}
#version 450
highp float;

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void) {
    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        for(int vertexNdx = 0; vertexNdx < gl_in.length(); vertexNdx++) {
            gl_Position = gl_in[vertexNdx].gl_Position;
            gl_Layer    = layerNdx;
            EmitVertex();
        };
        EndPrimitive();
    };
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out vec4 o_color0;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = vec4(1.0);
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = vec4(1.0);
	o_color1 = vec4(1.0);
	o_color2 = vec4(1.0);
	o_color3 = vec4(1.0);
}
#version 450
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
void main (void)
{
	o_color0 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color1 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color2 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color3 = vec4(0.0, 0.4, 0.8, 1.0);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform subpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform subpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform subpassInput i_color3;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color0)*0.5 + subpassLoad(i_color2)*0.25;
	o_color1 = subpassLoad(i_color1)*0.5 + subpassLoad(i_color3)*0.25;
}
#version 450
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
layout(location = 4) out vec4 o_color4;
layout(location = 5) out vec4 o_color5;
layout(location = 6) out vec4 o_color6;
layout(location = 7) out vec4 o_color7;
void main (void)
{
	o_color0 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color1 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color2 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color3 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color4 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color5 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color6 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color7 = vec4(0.0, 0.4, 0.8, 1.0);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform subpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform subpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform subpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform subpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform subpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform subpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform subpassInput i_color7;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color0)*0.5 + subpassLoad(i_color4)*0.25;
	o_color1 = subpassLoad(i_color1)*0.5 + subpassLoad(i_color5)*0.25;
	o_color2 = subpassLoad(i_color2)*0.5 + subpassLoad(i_color6)*0.25;
	o_color3 = subpassLoad(i_color3)*0.5 + subpassLoad(i_color7)*0.25;
}
#version 450
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
layout(location = 4) out vec4 o_color4;
layout(location = 5) out vec4 o_color5;
layout(location = 6) out vec4 o_color6;
layout(location = 7) out vec4 o_color7;
layout(location = 8) out vec4 o_color8;
layout(location = 9) out vec4 o_color9;
layout(location = 10) out vec4 o_color10;
layout(location = 11) out vec4 o_color11;
layout(location = 12) out vec4 o_color12;
layout(location = 13) out vec4 o_color13;
layout(location = 14) out vec4 o_color14;
layout(location = 15) out vec4 o_color15;
void main (void)
{
	o_color0 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color1 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color2 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color3 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color4 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color5 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color6 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color7 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color8 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color9 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color10 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color11 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color12 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color13 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color14 = vec4(0.0, 0.4, 0.8, 1.0);
	o_color15 = vec4(0.0, 0.4, 0.8, 1.0);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform subpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform subpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform subpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform subpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform subpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform subpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform subpassInput i_color7;
layout (input_attachment_index = 8, set = 0, binding = 8) uniform subpassInput i_color8;
layout (input_attachment_index = 9, set = 0, binding = 9) uniform subpassInput i_color9;
layout (input_attachment_index = 10, set = 0, binding = 10) uniform subpassInput i_color10;
layout (input_attachment_index = 11, set = 0, binding = 11) uniform subpassInput i_color11;
layout (input_attachment_index = 12, set = 0, binding = 12) uniform subpassInput i_color12;
layout (input_attachment_index = 13, set = 0, binding = 13) uniform subpassInput i_color13;
layout (input_attachment_index = 14, set = 0, binding = 14) uniform subpassInput i_color14;
layout (input_attachment_index = 15, set = 0, binding = 15) uniform subpassInput i_color15;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
layout(location = 4) out vec4 o_color4;
layout(location = 5) out vec4 o_color5;
layout(location = 6) out vec4 o_color6;
layout(location = 7) out vec4 o_color7;
void main (void)
{
	o_color0 = subpassLoad(i_color0)*0.5 + subpassLoad(i_color8)*0.25;
	o_color1 = subpassLoad(i_color1)*0.5 + subpassLoad(i_color9)*0.25;
	o_color2 = subpassLoad(i_color2)*0.5 + subpassLoad(i_color10)*0.25;
	o_color3 = subpassLoad(i_color3)*0.5 + subpassLoad(i_color11)*0.25;
	o_color4 = subpassLoad(i_color4)*0.5 + subpassLoad(i_color12)*0.25;
	o_color5 = subpassLoad(i_color5)*0.5 + subpassLoad(i_color13)*0.25;
	o_color6 = subpassLoad(i_color6)*0.5 + subpassLoad(i_color14)*0.25;
	o_color7 = subpassLoad(i_color7)*0.5 + subpassLoad(i_color15)*0.25;
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out uvec4 o_color0;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = uvec4(255);
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = uvec4(255);
	o_color1 = uvec4(255);
	o_color2 = uvec4(255);
	o_color3 = uvec4(255);
}
#version 450
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
void main (void)
{
	o_color0 = uvec4(0, 64, 192, 252);
	o_color1 = uvec4(0, 64, 192, 252);
	o_color2 = uvec4(0, 64, 192, 252);
	o_color3 = uvec4(0, 64, 192, 252);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform usubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform usubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform usubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform usubpassInput i_color3;
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color2) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color3) / 4;
}
#version 450
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
layout(location = 4) out uvec4 o_color4;
layout(location = 5) out uvec4 o_color5;
layout(location = 6) out uvec4 o_color6;
layout(location = 7) out uvec4 o_color7;
void main (void)
{
	o_color0 = uvec4(0, 64, 192, 252);
	o_color1 = uvec4(0, 64, 192, 252);
	o_color2 = uvec4(0, 64, 192, 252);
	o_color3 = uvec4(0, 64, 192, 252);
	o_color4 = uvec4(0, 64, 192, 252);
	o_color5 = uvec4(0, 64, 192, 252);
	o_color6 = uvec4(0, 64, 192, 252);
	o_color7 = uvec4(0, 64, 192, 252);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform usubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform usubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform usubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform usubpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform usubpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform usubpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform usubpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform usubpassInput i_color7;
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color4) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color5) / 4;
	o_color2 = subpassLoad(i_color2) / 2 + subpassLoad(i_color6) / 4;
	o_color3 = subpassLoad(i_color3) / 2 + subpassLoad(i_color7) / 4;
}
#version 450
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
layout(location = 4) out uvec4 o_color4;
layout(location = 5) out uvec4 o_color5;
layout(location = 6) out uvec4 o_color6;
layout(location = 7) out uvec4 o_color7;
layout(location = 8) out uvec4 o_color8;
layout(location = 9) out uvec4 o_color9;
layout(location = 10) out uvec4 o_color10;
layout(location = 11) out uvec4 o_color11;
layout(location = 12) out uvec4 o_color12;
layout(location = 13) out uvec4 o_color13;
layout(location = 14) out uvec4 o_color14;
layout(location = 15) out uvec4 o_color15;
void main (void)
{
	o_color0 = uvec4(0, 64, 192, 252);
	o_color1 = uvec4(0, 64, 192, 252);
	o_color2 = uvec4(0, 64, 192, 252);
	o_color3 = uvec4(0, 64, 192, 252);
	o_color4 = uvec4(0, 64, 192, 252);
	o_color5 = uvec4(0, 64, 192, 252);
	o_color6 = uvec4(0, 64, 192, 252);
	o_color7 = uvec4(0, 64, 192, 252);
	o_color8 = uvec4(0, 64, 192, 252);
	o_color9 = uvec4(0, 64, 192, 252);
	o_color10 = uvec4(0, 64, 192, 252);
	o_color11 = uvec4(0, 64, 192, 252);
	o_color12 = uvec4(0, 64, 192, 252);
	o_color13 = uvec4(0, 64, 192, 252);
	o_color14 = uvec4(0, 64, 192, 252);
	o_color15 = uvec4(0, 64, 192, 252);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform usubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform usubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform usubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform usubpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform usubpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform usubpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform usubpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform usubpassInput i_color7;
layout (input_attachment_index = 8, set = 0, binding = 8) uniform usubpassInput i_color8;
layout (input_attachment_index = 9, set = 0, binding = 9) uniform usubpassInput i_color9;
layout (input_attachment_index = 10, set = 0, binding = 10) uniform usubpassInput i_color10;
layout (input_attachment_index = 11, set = 0, binding = 11) uniform usubpassInput i_color11;
layout (input_attachment_index = 12, set = 0, binding = 12) uniform usubpassInput i_color12;
layout (input_attachment_index = 13, set = 0, binding = 13) uniform usubpassInput i_color13;
layout (input_attachment_index = 14, set = 0, binding = 14) uniform usubpassInput i_color14;
layout (input_attachment_index = 15, set = 0, binding = 15) uniform usubpassInput i_color15;
layout(location = 0) out uvec4 o_color0;
layout(location = 1) out uvec4 o_color1;
layout(location = 2) out uvec4 o_color2;
layout(location = 3) out uvec4 o_color3;
layout(location = 4) out uvec4 o_color4;
layout(location = 5) out uvec4 o_color5;
layout(location = 6) out uvec4 o_color6;
layout(location = 7) out uvec4 o_color7;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color8) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color9) / 4;
	o_color2 = subpassLoad(i_color2) / 2 + subpassLoad(i_color10) / 4;
	o_color3 = subpassLoad(i_color3) / 2 + subpassLoad(i_color11) / 4;
	o_color4 = subpassLoad(i_color4) / 2 + subpassLoad(i_color12) / 4;
	o_color5 = subpassLoad(i_color5) / 2 + subpassLoad(i_color13) / 4;
	o_color6 = subpassLoad(i_color6) / 2 + subpassLoad(i_color14) / 4;
	o_color7 = subpassLoad(i_color7) / 2 + subpassLoad(i_color15) / 4;
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out ivec4 o_color0;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = ivec4(127);
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = ivec4(127);
	o_color1 = ivec4(127);
	o_color2 = ivec4(127);
	o_color3 = ivec4(127);
}
#version 450
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
void main (void)
{
	o_color0 = ivec4(0, 32, 100, 124);
	o_color1 = ivec4(0, 32, 100, 124);
	o_color2 = ivec4(0, 32, 100, 124);
	o_color3 = ivec4(0, 32, 100, 124);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform isubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform isubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform isubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform isubpassInput i_color3;
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color2) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color3) / 4;
}
#version 450
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
layout(location = 4) out ivec4 o_color4;
layout(location = 5) out ivec4 o_color5;
layout(location = 6) out ivec4 o_color6;
layout(location = 7) out ivec4 o_color7;
void main (void)
{
	o_color0 = ivec4(0, 32, 100, 124);
	o_color1 = ivec4(0, 32, 100, 124);
	o_color2 = ivec4(0, 32, 100, 124);
	o_color3 = ivec4(0, 32, 100, 124);
	o_color4 = ivec4(0, 32, 100, 124);
	o_color5 = ivec4(0, 32, 100, 124);
	o_color6 = ivec4(0, 32, 100, 124);
	o_color7 = ivec4(0, 32, 100, 124);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform isubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform isubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform isubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform isubpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform isubpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform isubpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform isubpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform isubpassInput i_color7;
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color4) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color5) / 4;
	o_color2 = subpassLoad(i_color2) / 2 + subpassLoad(i_color6) / 4;
	o_color3 = subpassLoad(i_color3) / 2 + subpassLoad(i_color7) / 4;
}
#version 450
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
layout(location = 4) out ivec4 o_color4;
layout(location = 5) out ivec4 o_color5;
layout(location = 6) out ivec4 o_color6;
layout(location = 7) out ivec4 o_color7;
layout(location = 8) out ivec4 o_color8;
layout(location = 9) out ivec4 o_color9;
layout(location = 10) out ivec4 o_color10;
layout(location = 11) out ivec4 o_color11;
layout(location = 12) out ivec4 o_color12;
layout(location = 13) out ivec4 o_color13;
layout(location = 14) out ivec4 o_color14;
layout(location = 15) out ivec4 o_color15;
void main (void)
{
	o_color0 = ivec4(0, 32, 100, 124);
	o_color1 = ivec4(0, 32, 100, 124);
	o_color2 = ivec4(0, 32, 100, 124);
	o_color3 = ivec4(0, 32, 100, 124);
	o_color4 = ivec4(0, 32, 100, 124);
	o_color5 = ivec4(0, 32, 100, 124);
	o_color6 = ivec4(0, 32, 100, 124);
	o_color7 = ivec4(0, 32, 100, 124);
	o_color8 = ivec4(0, 32, 100, 124);
	o_color9 = ivec4(0, 32, 100, 124);
	o_color10 = ivec4(0, 32, 100, 124);
	o_color11 = ivec4(0, 32, 100, 124);
	o_color12 = ivec4(0, 32, 100, 124);
	o_color13 = ivec4(0, 32, 100, 124);
	o_color14 = ivec4(0, 32, 100, 124);
	o_color15 = ivec4(0, 32, 100, 124);
}
#version 450
layout (input_attachment_index = 0, set = 0, binding = 0) uniform isubpassInput i_color0;
layout (input_attachment_index = 1, set = 0, binding = 1) uniform isubpassInput i_color1;
layout (input_attachment_index = 2, set = 0, binding = 2) uniform isubpassInput i_color2;
layout (input_attachment_index = 3, set = 0, binding = 3) uniform isubpassInput i_color3;
layout (input_attachment_index = 4, set = 0, binding = 4) uniform isubpassInput i_color4;
layout (input_attachment_index = 5, set = 0, binding = 5) uniform isubpassInput i_color5;
layout (input_attachment_index = 6, set = 0, binding = 6) uniform isubpassInput i_color6;
layout (input_attachment_index = 7, set = 0, binding = 7) uniform isubpassInput i_color7;
layout (input_attachment_index = 8, set = 0, binding = 8) uniform isubpassInput i_color8;
layout (input_attachment_index = 9, set = 0, binding = 9) uniform isubpassInput i_color9;
layout (input_attachment_index = 10, set = 0, binding = 10) uniform isubpassInput i_color10;
layout (input_attachment_index = 11, set = 0, binding = 11) uniform isubpassInput i_color11;
layout (input_attachment_index = 12, set = 0, binding = 12) uniform isubpassInput i_color12;
layout (input_attachment_index = 13, set = 0, binding = 13) uniform isubpassInput i_color13;
layout (input_attachment_index = 14, set = 0, binding = 14) uniform isubpassInput i_color14;
layout (input_attachment_index = 15, set = 0, binding = 15) uniform isubpassInput i_color15;
layout(location = 0) out ivec4 o_color0;
layout(location = 1) out ivec4 o_color1;
layout(location = 2) out ivec4 o_color2;
layout(location = 3) out ivec4 o_color3;
layout(location = 4) out ivec4 o_color4;
layout(location = 5) out ivec4 o_color5;
layout(location = 6) out ivec4 o_color6;
layout(location = 7) out ivec4 o_color7;
void main (void)
{
	o_color0 = subpassLoad(i_color0) / 2 + subpassLoad(i_color8) / 4;
	o_color1 = subpassLoad(i_color1) / 2 + subpassLoad(i_color9) / 4;
	o_color2 = subpassLoad(i_color2) / 2 + subpassLoad(i_color10) / 4;
	o_color3 = subpassLoad(i_color3) / 2 + subpassLoad(i_color11) / 4;
	o_color4 = subpassLoad(i_color4) / 2 + subpassLoad(i_color12) / 4;
	o_color5 = subpassLoad(i_color5) / 2 + subpassLoad(i_color13) / 4;
	o_color6 = subpassLoad(i_color6) / 2 + subpassLoad(i_color14) / 4;
	o_color7 = subpassLoad(i_color7) / 2 + subpassLoad(i_color15) / 4;
}
