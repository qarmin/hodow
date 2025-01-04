#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 1) out mediump vec4 v_in0;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float res = float(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 res = vec4(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 res = vec4(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_color;

void main()
{
    o_color = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int res = int(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 res = ivec3(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 1) out highp vec4 v_in0;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 res = uvec4(0.0);

	res = -in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bool res = bool(0.0);

	res = !in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = ~in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-05, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int res = int(0.0);

	res = ~in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-05, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 res = ivec4(0.0);

	res = ~in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-05, 5e-05, 5e-05, 5e-05) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = ~in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = ~in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float res = float(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp float res = float(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 res = vec3(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int res = int(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	++res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp float res = float(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(1.00, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 res = vec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0) + vec4(1.00, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 res = vec4(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(1.00, 1.00, 1.00, 1.00);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int res = int(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint res = uint(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint res = uint(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	--res;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float res = float(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 res = vec3(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 res = vec4(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(1.00, 1.00, 1.00, 1.00);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 res = vec4(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(1.00, 1.00, 1.00, 1.00);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint res = uint(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp float in0 = v_in0.z;
	highp float res = float(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 res = vec3(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int res = int(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 res = ivec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint res = uint(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 res = uvec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = ++in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float res = float(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(1.00, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int res = int(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int res = int(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 res = ivec3(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 res = ivec4(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 res = ivec4(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 res = uvec3(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 res = uvec4(0.0);

	res = --in0;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float res = float(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 res = vec4(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int res = int(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int res = int(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 res = ivec2(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 res = ivec2(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 res = ivec4(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 res = ivec4(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 res = uvec3(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 res = uvec3(0.0);

	res = in0++;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp float in0 = v_in0.z;
	highp float res = float(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
	color = color * vec4(0.5, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 res = vec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 res = vec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
	color = color * vec4(1.0, 0.5, 0.5, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 res = ivec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 res = ivec3(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 res = uvec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 res = uvec2(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 res = uvec4(0.0);

	res = in0--;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 1) out highp vec4 v_in0;
layout(location = 2) out highp vec4 v_in1;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp float in0 = v_in0.z;
	highp float in1 = v_in1.x;
	bool res = bool(0.0);

	res = in0 < in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 < in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	bool res = bool(0.0);

	res = in0 <= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	bool res = bool(0.0);

	res = in0 <= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	bool res = bool(0.0);

	res = in0 > in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 > in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float in1 = a_in1.x;
	bool res = bool(0.0);

	res = in0 >= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	bool res = bool(0.0);

	res = in0 >= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 >= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 1) out mediump vec4 v_in0;
layout(location = 2) out mediump vec4 v_in1;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float in1 = v_in1.x;
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(a_in1.yx, vec2(0.0));
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	bvec2 in0 = greaterThan(v_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(v_in1.yx, vec2(0.0));
	bool res = bool(0.0);

	res = in0 == in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 in1 = v_in1.wzyx;
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool in1 = (a_in1.x > 0.0);
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(a_in1.yx, vec2(0.0));
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	bvec2 in0 = greaterThan(v_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(v_in1.yx, vec2(0.0));
	bool res = bool(0.0);

	res = in0 != in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool in1 = (a_in1.x > 0.0);
	bool res = bool(0.0);

	res = in0 || in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool in1 = (a_in1.x > 0.0);
	bool res = bool(0.0);

	res = in0 ^^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int in1 = int(a_in1.x);
	highp int res = int(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = min(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int in1 = int(a_in1.x);
	highp int res = int(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = max(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 1) out highp vec4 v_in0;
layout(location = 2) out highp vec4 v_in1;
layout(location = 3) out highp vec4 v_in2;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 in2 = ivec2(v_in2.zy);
	mediump ivec2 res = ivec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 in2 = ivec2(a_in2.zy);
	highp ivec2 res = ivec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp int in2 = int(a_in2.y);
	highp ivec2 res = ivec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump int in2 = int(a_in2.y);
	mediump ivec3 res = ivec3(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump int in2 = int(v_in2.y);
	mediump ivec3 res = ivec3(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump int in2 = int(v_in2.y);
	mediump ivec4 res = ivec4(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp int in2 = int(a_in2.y);
	highp ivec4 res = ivec4(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.125, 0.125, 0.125, 0.125) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint in2 = uint(a_in2.y);
	highp uint res = uint(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.125, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 in2 = uvec2(a_in2.zy);
	mediump uvec2 res = uvec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 in2 = uvec2(v_in2.zy);
	highp uvec2 res = uvec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uint in2 = uint(v_in2.y);
	mediump uvec2 res = uvec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uint in2 = uint(v_in2.y);
	highp uvec2 res = uvec2(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uint in2 = uint(v_in2.y);
	mediump uvec3 res = uvec3(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uint in2 = uint(v_in2.y);
	highp uvec3 res = uvec3(0.0);

	res = clamp(in0, in1, in2);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.125, 0.125, 0.125, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	bvec2 res = bvec2(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec3 in0 = a_in0.zxy;
	mediump vec3 in1 = a_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp vec3 in1 = v_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	bvec2 res = bvec2(0.0);

	res = lessThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = lessThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = lessThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec3 in0 = a_in0.zxy;
	mediump vec3 in1 = a_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp vec3 in1 = v_in1.yzx;
	bvec3 res = bvec3(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 in1 = v_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	bvec4 res = bvec4(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	bvec3 res = bvec3(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	bvec3 res = bvec3(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 res = bvec4(0.0);

	res = lessThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = lessThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 res = bvec4(0.0);

	res = greaterThan(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = greaterThanEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	bvec3 res = bvec3(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	bvec3 res = bvec3(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	bvec3 res = bvec3(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 res = bvec4(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec3 in0 = greaterThan(a_in0.zxy, vec3(0.0));
	bvec3 in1 = greaterThan(a_in1.yzx, vec3(0.0));
	bvec3 res = bvec3(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	bvec4 in0 = greaterThan(v_in0.yzwx, vec4(0.0));
	bvec4 in1 = greaterThan(v_in1.wzyx, vec4(0.0));
	bvec4 res = bvec4(0.0);

	res = equal(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(a_in1.yx, vec2(0.0));
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	bvec2 in0 = greaterThan(v_in0.wy, vec2(0.0));
	bvec2 in1 = greaterThan(v_in1.yx, vec2(0.0));
	bvec2 res = bvec2(0.0);

	res = notEqual(in0, in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bool res = bool(0.0);

	res = any(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bvec2 in0 = greaterThan(a_in0.wy, vec2(0.0));
	bool res = bool(0.0);

	res = all(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	bvec3 in0 = greaterThan(v_in0.zxy, vec3(0.0));
	bool res = bool(0.0);

	res = all(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;

void main()
{
	bvec4 in0 = greaterThan(v_in0.yzwx, vec4(0.0));
	bvec4 res = bvec4(0.0);

	res = not(in0);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 in1 = a_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec3 in0 = a_in0.zxy;
	mediump vec3 in1 = a_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp vec3 in1 = v_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int in1 = int(a_in1.x);
	highp int res = int(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(4e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.005, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump float in1 = a_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp float in1 = a_in1.x;
	highp vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp vec2 in1 = a_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 + in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp float in1 = a_in1.x;
	highp float res = float(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(4e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp float in1 = a_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp float in1 = v_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp float in1 = a_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp vec3 in1 = a_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp float in0 = v_in0.z;
	highp vec3 in1 = v_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump vec4 in1 = a_in1.wzyx;
	mediump vec4 res = vec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 - in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp float in0 = v_in0.z;
	highp float in1 = v_in1.x;
	highp float res = float(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump float in1 = a_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 * in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float in1 = v_in1.x;
	mediump float res = float(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp float in1 = a_in1.x;
	highp float res = float(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(1e-05, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp float in1 = a_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp float in1 = v_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp float in1 = a_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0) + vec4(1.00, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp vec3 in1 = a_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp float in0 = v_in0.z;
	highp vec3 in1 = v_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump vec4 in1 = a_in1.wzyx;
	mediump vec4 res = vec4(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0) + vec4(1.00, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 / in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.25, 0.25, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 % in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 & in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 | in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(4e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 ^ in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump int res = int(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp int res = int(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-10, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp int in1 = int(a_in1.x);
	highp int res = int(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 << in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 >> in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float in1 = a_in1.x;
	mediump float res = float(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump float in1 = v_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp float in1 = v_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump float in1 = v_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp float in0 = v_in0.z;
	highp float in1 = v_in1.x;
	highp float res = float(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp float in1 = v_in1.x;
	highp vec2 res = vec2(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec3 in0 = a_in0.zxy;
	mediump float in1 = a_in1.x;
	mediump vec3 res = vec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump float in1 = v_in1.x;
	mediump vec3 res = vec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp float in1 = a_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump float in1 = a_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp float in1 = a_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp float in1 = v_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp float in1 = a_in1.x;
	highp float res = float(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(4e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float in1 = a_in1.x;
	mediump float res = float(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	mediump vec4 res = vec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp vec4 in1 = a_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.04, 1.0, 1.0, 1.0) + vec4(1.00, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.04, 0.04, 0.04, 0.04) + vec4(1.00, 1.00, 1.00, 1.00);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(1e-05, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump float in1 = a_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump float in1 = v_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump float in1 = v_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0) + vec4(0.0, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.04, 0.04, 0.04, 0.04) + vec4(1.00, 1.00, 1.00, 1.00);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.25, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.25, 0.25, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp int in0 = int(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp int res = int(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-10, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0;
	res >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump vec4 in1 = v_in1.wzyx;
	mediump vec4 res = vec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.005, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump float in1 = a_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump float in1 = v_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump float in1 = v_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 += in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 in1 = a_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump float in1 = v_in1.x;
	mediump vec3 res = vec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp float in1 = a_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec4 in0 = a_in0.yzwx;
	highp float in1 = a_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.005, 0.005, 0.005, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.005, 0.005, 0.005, 0.005);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 -= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump float in1 = a_in1.x;
	mediump float res = float(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec2 in0 = a_in0.wy;
	mediump vec2 in1 = a_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump vec2 in1 = v_in1.yx;
	mediump vec2 res = vec2(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp vec2 in1 = v_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec3 in0 = a_in0.zxy;
	highp vec3 in1 = a_in1.yzx;
	highp vec3 res = vec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump int in0 = int(a_in0.z);
	mediump int in1 = int(a_in1.x);
	mediump int res = int(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump int in0 = int(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump int res = int(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp uint in1 = uint(a_in1.x);
	highp uint res = uint(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uvec2 in1 = uvec2(a_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uvec3 in1 = uvec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec2 in0 = v_in0.wy;
	highp float in1 = v_in1.x;
	highp vec2 res = vec2(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec3 in0 = a_in0.zxy;
	mediump float in1 = a_in1.x;
	mediump vec3 res = vec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump float in1 = a_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp float in1 = v_in1.x;
	highp vec4 res = vec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp int in1 = int(a_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 *= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump float in0 = v_in0.z;
	mediump float in1 = v_in1.x;
	mediump float res = float(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp vec2 in0 = a_in0.wy;
	highp vec2 in1 = a_in1.yx;
	highp vec2 res = vec2(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec3 in0 = v_in0.zxy;
	mediump vec3 in1 = v_in1.yzx;
	mediump vec3 res = vec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	mediump vec4 res = vec4(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	highp vec4 res = vec4(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0) + vec4(1.00, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.04, 0.04, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.04, 0.04, 0.04, 0.04);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(1e-05, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1e-05);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec2 in0 = v_in0.wy;
	mediump float in1 = v_in1.x;
	mediump vec2 res = vec2(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp vec3 in0 = v_in0.zxy;
	highp float in1 = v_in1.x;
	highp vec3 res = vec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump float in1 = v_in1.x;
	mediump vec4 res = vec4(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.04, 0.04, 0.04, 1.0) + vec4(1.00, 1.00, 1.00, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 /= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(1e-05, 1e-05, 1e-05, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp int in0 = int(v_in0.z);
	highp int in1 = int(v_in1.x);
	highp int res = int(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.1, 1.0, 1.0, 1.0) + vec4(0.50, 0.0, 0.0, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.25, 0.25, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp uvec2 res = uvec2(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uvec3 in1 = uvec3(a_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.25, 0.25, 0.25, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp ivec3 res = ivec3(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec4 in0 = ivec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 %= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.25, 0.25, 0.25, 0.25);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec3 in0 = uvec3(a_in0.zxy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uint in1 = uint(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 &= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump uint in1 = uint(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uint in0 = uint(v_in0.z);
	highp uint in1 = uint(v_in1.x);
	highp uint res = uint(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(2e-10, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec3 in0 = uvec3(a_in0.zxy);
	highp uint in1 = uint(a_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uint in1 = uint(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 |= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.03, 0.03, 0.03, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec3 in0 = ivec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.03, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(2e-10, 2e-10, 2e-10, 2e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 4e-10, 4e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp ivec4 res = ivec4(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(4e-10, 4e-10, 4e-10, 4e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec2 in0 = uvec2(a_in0.wy);
	mediump uint in1 = uint(a_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.03, 0.03, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 ^= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.03, 0.03, 0.03, 0.03);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump uvec2 in1 = uvec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump uvec3 in1 = uvec3(a_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump ivec4 res = ivec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp uvec2 in1 = uvec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uint in0 = uint(a_in0.z);
	mediump uint in1 = uint(a_in1.x);
	mediump uint res = uint(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump uint in1 = uint(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec2 in0 = ivec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp uint in1 = uint(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump ivec2 in1 = ivec2(v_in1.yx);
	mediump uvec2 res = uvec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp uvec3 res = uvec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp ivec4 in1 = ivec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp ivec4 in1 = ivec4(v_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump int in1 = int(a_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec4 in0 = ivec4(a_in0.yzwx);
	mediump int in1 = int(a_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec4 in0 = ivec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump ivec4 res = ivec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp int in1 = int(v_in1.x);
	highp ivec2 res = ivec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp int in1 = int(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec4 in0 = uvec4(v_in0.yzwx);
	highp int in1 = int(v_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 <<= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump uvec2 in1 = uvec2(v_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec4 in0 = ivec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp ivec4 res = ivec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10) + vec4(0.50, 0.50, 0.50, 0.50);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump uvec4 in1 = uvec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp uvec4 in1 = uvec4(a_in1.wzyx);
	highp uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec2 in0 = uvec2(v_in0.wy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec2 res = uvec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump uint in1 = uint(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec2 in0 = uvec2(v_in0.wy);
	highp uint in1 = uint(v_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp uvec3 in0 = uvec3(v_in0.zxy);
	highp uint in1 = uint(v_in1.x);
	highp uvec3 res = uvec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec2 in0 = ivec2(a_in0.wy);
	mediump ivec2 in1 = ivec2(a_in1.yx);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec3 in0 = ivec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump ivec3 res = ivec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	highp ivec2 in0 = ivec2(v_in0.wy);
	highp ivec2 in1 = ivec2(v_in1.yx);
	highp ivec2 res = ivec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp ivec3 in0 = ivec3(a_in0.zxy);
	highp ivec3 in1 = ivec3(a_in1.yzx);
	highp ivec3 res = ivec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uint in0 = uint(v_in0.z);
	mediump int in1 = int(v_in1.x);
	mediump uint res = uint(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.004, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump ivec3 in1 = ivec3(v_in1.yzx);
	mediump uvec3 res = uvec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump uvec4 in0 = uvec4(a_in0.yzwx);
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uint in0 = uint(a_in0.z);
	highp int in1 = int(a_in1.x);
	highp uint res = uint(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(5e-10, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump ivec2 in0 = ivec2(v_in0.wy);
	mediump int in1 = int(v_in1.x);
	mediump ivec2 res = ivec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.004, 0.004, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump ivec3 in0 = ivec3(a_in0.zxy);
	mediump int in1 = int(a_in1.x);
	mediump ivec3 res = ivec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec3 in0 = uvec3(v_in0.zxy);
	mediump int in1 = int(v_in1.x);
	mediump uvec3 res = uvec3(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.004, 0.004, 0.004, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;

void main()
{
	mediump uvec4 in0 = uvec4(v_in0.yzwx);
	mediump int in1 = int(v_in1.x);
	mediump uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.004, 0.004, 0.004, 0.004);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec2 in0 = uvec2(a_in0.wy);
	highp int in1 = int(a_in1.x);
	highp uvec2 res = uvec2(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 5e-10, 5e-10, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp uvec4 in0 = uvec4(a_in0.yzwx);
	highp int in1 = int(a_in1.x);
	highp uvec4 res = uvec4(0.0);

	res = in0 >>= in1;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(5e-10, 5e-10, 5e-10, 5e-10);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump vec3 in1 = a_in1.yzx;
	mediump vec3 in2 = a_in2.wyz;
	mediump vec3 res = vec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 1) out mediump vec4 v_in0;
layout(location = 2) out highp vec4 v_in1;
layout(location = 3) out highp vec4 v_in2;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp vec3 in1 = v_in1.yzx;
	highp vec3 in2 = v_in2.wyz;
	highp vec3 res = vec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = res;
	color = color * vec4(0.5, 0.5, 0.5, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 1) out mediump vec4 v_in0;
layout(location = 2) out mediump vec4 v_in1;
layout(location = 3) out mediump vec4 v_in2;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	mediump vec4 in1 = v_in1.wzyx;
	mediump vec4 in2 = v_in2.xwzy;
	mediump vec4 res = vec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	highp ivec2 in1 = ivec2(a_in1.yx);
	highp ivec2 in2 = ivec2(a_in2.zy);
	highp ivec2 res = ivec2(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.1, 0.1, 1.0) + vec4(0.0, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump ivec3 in1 = ivec3(a_in1.yzx);
	mediump ivec3 in2 = ivec3(a_in2.wyz);
	mediump ivec3 res = ivec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp ivec3 in1 = ivec3(v_in1.yzx);
	highp ivec3 in2 = ivec3(v_in2.wyz);
	highp ivec3 res = ivec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.1, 0.1, 0.1, 1.0) + vec4(0.50, 0.50, 0.50, 0.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	mediump ivec4 in2 = ivec4(v_in2.xwzy);
	mediump ivec4 res = ivec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.1, 0.1, 0.1, 0.1) + vec4(0.50, 0.50, 0.50, 0.50);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump uint in1 = uint(a_in1.x);
	mediump uint in2 = uint(a_in2.y);
	mediump uint res = uint(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	mediump uint in1 = uint(v_in1.x);
	mediump uint in2 = uint(v_in2.y);
	mediump uint res = uint(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	mediump uvec3 in1 = uvec3(v_in1.yzx);
	mediump uvec3 in2 = uvec3(v_in2.wyz);
	mediump uvec3 res = uvec3(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyz = vec3(res);
	color = color * vec4(0.5, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	mediump uvec4 in1 = uvec4(a_in1.wzyx);
	mediump uvec4 in2 = uvec4(a_in2.xwzy);
	mediump uvec4 res = uvec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	highp uvec4 in1 = uvec4(v_in1.wzyx);
	highp uvec4 in2 = uvec4(v_in2.xwzy);
	highp uvec4 res = uvec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bool in1 = (a_in1.x > 0.0);
	bool in2 = (a_in2.y > 0.0);
	bool res = bool(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bool in1 = (v_in1.x > 0.0);
	bool in2 = (v_in2.y > 0.0);
	bool res = bool(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	bool in0 = (a_in0.z > 0.0);
	bvec4 in1 = greaterThan(a_in1.wzyx, vec4(0.0));
	bvec4 in2 = greaterThan(a_in2.xwzy, vec4(0.0));
	bvec4 res = bvec4(0.0);

	res = in0 ? in1 : in2;

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump float in0 = a_in0.z;
	mediump uint in1 = uint(a_in1.x);
	mediump float in2 = a_in2.y;
	mediump uint res = uint(0.0);

	res = (in0 + in2, in1 + in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 1) out mediump vec4 v_in0;
layout(location = 2) out highp vec4 v_in1;
layout(location = 3) out mediump vec4 v_in2;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	mediump float in0 = v_in0.z;
	mediump uint in1 = uint(v_in1.x);
	mediump float in2 = v_in2.y;
	mediump uint res = uint(0.0);

	res = (in0 + in2, in1 + in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	highp float in0 = a_in0.z;
	highp uint in1 = uint(a_in1.x);
	highp float in2 = a_in2.y;
	highp uint res = uint(0.0);

	res = (in0 + in2, in1 + in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp float in0 = v_in0.z;
	highp uint in1 = uint(v_in1.x);
	highp float in2 = v_in2.y;
	highp uint res = uint(0.0);

	res = (in0 + in2, in1 + in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in highp vec4 a_in2;
layout(location = 1) out mediump vec4 v_in0;
layout(location = 2) out mediump vec4 v_in1;
layout(location = 3) out highp vec4 v_in2;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bool in1 = (v_in1.x > 0.0);
	highp vec2 in2 = v_in2.zy;
	highp ivec2 res = ivec2(0.0);

	res = (in0 && in1, in0, ivec2(vec2(in0) + in2));

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in mediump vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump vec4 in1 = a_in1.wzyx;
	mediump vec4 in2 = a_in2.xwzy;
	mediump vec4 res = vec4(0.0);

	res = (in0++, in1 = in0 + in2, in2 = in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in highp vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	highp vec4 in0 = v_in0.yzwx;
	highp vec4 in1 = v_in1.wzyx;
	highp vec4 in2 = v_in2.xwzy;
	highp vec4 res = vec4(0.0);

	res = (in0++, in1 = in0 + in2, in2 = in1);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = res;
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	mediump float in0 = v_in0.z;
	mediump uint in1 = uint(v_in1.x);
	mediump float in2 = v_in2.y;
	mediump uint res = uint(0.0);

	res = (in1++, in0 = float(in1), in1 = uint(in0 + in2));

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.x = float(res);
	color = color * vec4(0.5, 1.0, 1.0, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in mediump vec4 v_in1;
layout(location = 3) in highp vec4 v_in2;

void main()
{
	bool in0 = (v_in0.z > 0.0);
	bool in1 = (v_in1.x > 0.0);
	highp vec2 in2 = v_in2.zy;
	highp ivec2 res = ivec2(0.0);

	res = (in1 = in0, in2++, in2 = in2 + vec2(in1), ivec2(in2));

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.yz = vec2(res);
	color = color * vec4(1.0, 0.5, 0.5, 1.0);
    o_color = color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 6) in mediump vec4 a_in2;
layout(location = 0) out mediump vec4 v_color;

void main()
{
    gl_Position = a_position;
	mediump vec4 in0 = a_in0.yzwx;
	mediump ivec4 in1 = ivec4(a_in1.wzyx);
	bvec4 in2 = greaterThan(a_in2.xwzy, vec4(0.0));
	mediump ivec4 res = ivec4(0.0);

	res = (in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    v_color = color;
}
#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 1) in mediump vec4 v_in0;
layout(location = 2) in highp vec4 v_in1;
layout(location = 3) in mediump vec4 v_in2;

void main()
{
	mediump vec4 in0 = v_in0.yzwx;
	mediump ivec4 in1 = ivec4(v_in1.wzyx);
	bvec4 in2 = greaterThan(v_in2.xwzy, vec4(0.0));
	mediump ivec4 res = ivec4(0.0);

	res = (in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++);

	highp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
	color.xyzw = vec4(res);
	color = color * vec4(0.5, 0.5, 0.5, 0.5);
    o_color = color;
}
