#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void)
{
    gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                       ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.5, 0.25, 0.125, 1.0);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(128u, 1073741824u, 536870912u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(64, 536870912, 268435456, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(128u, 64u, 536870912u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(64, 32, 268435456, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(128u, 64u, 32u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(64, 32, 16, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(512u, 256u, 128u, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(32768u, 1073741824u, 536870912u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(16384, 536870912, 268435456, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(32768u, 16384u, 536870912u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(16384, 8192, 268435456, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(32768u, 16384u, 8192u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(16384, 8192, 4096, 0xffffffff);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
void main (void)
{
    o_color = uvec4(2147483648u, 1073741824u, 536870912u, 0xffffffff);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
void main (void)
{
    o_color = ivec4(1073741824, 536870912, 268435456, 0xffffffff);
}
