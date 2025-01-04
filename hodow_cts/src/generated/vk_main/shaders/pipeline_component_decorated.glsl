#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float64_t o0;
layout(location = 1, component = 2) out flat float64_t o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float64_t(0.125);
    o2 = float64_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat float64_t i0;
layout(location = 1, component = 2) in flat float64_t i2;
void main()
{
    dEQP_color = vec4(float(i0), float(i2), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f64vec2 o0;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f64vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat f64vec2 i0;
void main()
{
    dEQP_color = vec4(vec2(i0), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float64_t o0[3];
layout(location = 3, component = 2) out flat float64_t o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float64_t(0.125);
    o2[2] = float64_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat float64_t i0[3];
layout(location = 3, component = 2) in flat float64_t i2[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), float(i2[2]), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f64vec2 o0[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f64vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat f64vec2 i0[3];
void main()
{
    dEQP_color = vec4(vec2(i0[2]), 0.5, 1);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat float o1;
layout(location = 1, component = 2) out flat float o2;
layout(location = 1, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.125);
    o1 = float(0.25);
    o2 = float(0.5);
    o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat float i0;
layout(location = 1, component = 1) in flat float i1;
layout(location = 1, component = 2) in flat float i2;
layout(location = 1, component = 3) in flat float i3;
void main()
{
    dEQP_color = vec4(float(i0), float(i1), float(i2), float(i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0;
layout(location = 2, component = 1) out flat float o1;
layout(location = 2, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.125);
    o1 = float(0.25);
    o2 = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat float i0;
layout(location = 2, component = 1) in flat float i1;
layout(location = 2, component = 2) in flat vec2 i2;
void main()
{
    dEQP_color = vec4(float(i0), float(i1), vec2(i2));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float o0;
layout(location = 3, component = 1) out flat vec2 o1;
layout(location = 3, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.125);
    o1 = vec2(0.25, 0.5);
    o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat float i0;
layout(location = 3, component = 1) in flat vec2 i1;
layout(location = 3, component = 3) in flat float i3;
void main()
{
    dEQP_color = vec4(float(i0), vec2(i1), float(i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat vec2 o0;
layout(location = 4, component = 2) out flat float o2;
layout(location = 4, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.125, 0.25);
    o2 = float(0.5);
    o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat vec2 i0;
layout(location = 4, component = 2) in flat float i2;
layout(location = 4, component = 3) in flat float i3;
void main()
{
    dEQP_color = vec4(vec2(i0), float(i2), float(i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.125);
    o1 = vec3(0.25, 0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat float i0;
layout(location = 1, component = 1) in flat vec3 i1;
void main()
{
    dEQP_color = vec4(float(i0), vec3(i1));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec3 o0;
layout(location = 2, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec3(0.125, 0.25, 0.5);
    o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat vec3 i0;
layout(location = 2, component = 3) in flat float i3;
void main()
{
    dEQP_color = vec4(vec3(i0), float(i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0;
layout(location = 3, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.125, 0.25);
    o2 = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat vec2 i0;
layout(location = 3, component = 2) in flat vec2 i2;
void main()
{
    dEQP_color = vec4(vec2(i0), vec2(i2));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat float o1[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.125);
    o1[2] = float(0.25);
    o2[2] = float(0.5);
    o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat float i0[3];
layout(location = 4, component = 1) in flat float i1[3];
layout(location = 4, component = 2) in flat float i2[3];
layout(location = 4, component = 3) in flat float i3[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), float(i1[2]), float(i2[2]), float(i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.125);
    o1[2] = float(0.25);
    o2[2] = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat float i0[3];
layout(location = 1, component = 1) in flat float i1[3];
layout(location = 1, component = 2) in flat vec2 i2[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), float(i1[2]), vec2(i2[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat vec2 o1[3];
layout(location = 2, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.125);
    o1[2] = vec2(0.25, 0.5);
    o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat float i0[3];
layout(location = 2, component = 1) in flat vec2 i1[3];
layout(location = 2, component = 3) in flat float i3[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), vec2(i1[2]), float(i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat float o2[3];
layout(location = 3, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.125, 0.25);
    o2[2] = float(0.5);
    o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat vec2 i0[3];
layout(location = 3, component = 2) in flat float i2[3];
layout(location = 3, component = 3) in flat float i3[3];
void main()
{
    dEQP_color = vec4(vec2(i0[2]), float(i2[2]), float(i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.125);
    o1[2] = vec3(0.25, 0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat float i0[3];
layout(location = 4, component = 1) in flat vec3 i1[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), vec3(i1[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat vec3 o0[3];
layout(location = 1, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec3(0.125, 0.25, 0.5);
    o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat vec3 i0[3];
layout(location = 1, component = 3) in flat float i3[3];
void main()
{
    dEQP_color = vec4(vec3(i0[2]), float(i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec2 o0[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.125, 0.25);
    o2[2] = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat vec2 i0[3];
layout(location = 2, component = 2) in flat vec2 i2[3];
void main()
{
    dEQP_color = vec4(vec2(i0[2]), vec2(i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat float16_t o1;
layout(location = 3, component = 2) out flat float16_t o2;
layout(location = 3, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.125);
    o1 = float16_t(0.25);
    o2 = float16_t(0.5);
    o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat float16_t i0;
layout(location = 3, component = 1) in flat float16_t i1;
layout(location = 3, component = 2) in flat float16_t i2;
layout(location = 3, component = 3) in flat float16_t i3;
void main()
{
    dEQP_color = vec4(float(i0), float(i1), float(i2), float(i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0;
layout(location = 4, component = 1) out flat float16_t o1;
layout(location = 4, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.125);
    o1 = float16_t(0.25);
    o2 = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat float16_t i0;
layout(location = 4, component = 1) in flat float16_t i1;
layout(location = 4, component = 2) in flat f16vec2 i2;
void main()
{
    dEQP_color = vec4(float(i0), float(i1), vec2(i2));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float16_t o0;
layout(location = 1, component = 1) out flat f16vec2 o1;
layout(location = 1, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.125);
    o1 = f16vec2(0.25, 0.5);
    o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat float16_t i0;
layout(location = 1, component = 1) in flat f16vec2 i1;
layout(location = 1, component = 3) in flat float16_t i3;
void main()
{
    dEQP_color = vec4(float(i0), vec2(i1), float(i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f16vec2 o0;
layout(location = 2, component = 2) out flat float16_t o2;
layout(location = 2, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.125, 0.25);
    o2 = float16_t(0.5);
    o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat f16vec2 i0;
layout(location = 2, component = 2) in flat float16_t i2;
layout(location = 2, component = 3) in flat float16_t i3;
void main()
{
    dEQP_color = vec4(vec2(i0), float(i2), float(i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat f16vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.125);
    o1 = f16vec3(0.25, 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat float16_t i0;
layout(location = 3, component = 1) in flat f16vec3 i1;
void main()
{
    dEQP_color = vec4(float(i0), vec3(i1));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec3 o0;
layout(location = 4, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec3(0.125, 0.25, 0.5);
    o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat f16vec3 i0;
layout(location = 4, component = 3) in flat float16_t i3;
void main()
{
    dEQP_color = vec4(vec3(i0), float(i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0;
layout(location = 1, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.125, 0.25);
    o2 = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat f16vec2 i0;
layout(location = 1, component = 2) in flat f16vec2 i2;
void main()
{
    dEQP_color = vec4(vec2(i0), vec2(i2));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat float16_t o1[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.125);
    o1[2] = float16_t(0.25);
    o2[2] = float16_t(0.5);
    o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat float16_t i0[3];
layout(location = 2, component = 1) in flat float16_t i1[3];
layout(location = 2, component = 2) in flat float16_t i2[3];
layout(location = 2, component = 3) in flat float16_t i3[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), float(i1[2]), float(i2[2]), float(i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.125);
    o1[2] = float16_t(0.25);
    o2[2] = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat float16_t i0[3];
layout(location = 3, component = 1) in flat float16_t i1[3];
layout(location = 3, component = 2) in flat f16vec2 i2[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), float(i1[2]), vec2(i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat f16vec2 o1[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.125);
    o1[2] = f16vec2(0.25, 0.5);
    o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat float16_t i0[3];
layout(location = 4, component = 1) in flat f16vec2 i1[3];
layout(location = 4, component = 3) in flat float16_t i3[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), vec2(i1[2]), float(i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat float16_t o2[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.125, 0.25);
    o2[2] = float16_t(0.5);
    o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1, component = 0) in flat f16vec2 i0[3];
layout(location = 1, component = 2) in flat float16_t i2[3];
layout(location = 1, component = 3) in flat float16_t i3[3];
void main()
{
    dEQP_color = vec4(vec2(i0[2]), float(i2[2]), float(i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat f16vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.125);
    o1[2] = f16vec3(0.25, 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2, component = 0) in flat float16_t i0[3];
layout(location = 2, component = 1) in flat f16vec3 i1[3];
void main()
{
    dEQP_color = vec4(float(i0[2]), vec3(i1[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat f16vec3 o0[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec3(0.125, 0.25, 0.5);
    o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3, component = 0) in flat f16vec3 i0[3];
layout(location = 3, component = 3) in flat float16_t i3[3];
void main()
{
    dEQP_color = vec4(vec3(i0[2]), float(i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec2 o0[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.125, 0.25);
    o2[2] = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4, component = 0) in flat f16vec2 i0[3];
layout(location = 4, component = 2) in flat f16vec2 i2[3];
void main()
{
    dEQP_color = vec4(vec2(i0[2]), vec2(i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float64_t(0.125);
    var_out.o2 = float64_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float64_t i0;
    layout(location = 1, component = 2)  flat float64_t i2;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), float(var_in.i2), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f64vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f64vec2 i0;
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float64_t(0.125);
    var_out.o2[2] = float64_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float64_t i0[3];
    layout(location = 3, component = 2)  flat float64_t i2[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), float(var_in.i2[2]), 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f64vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f64vec2 i0[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0[2]), 0.5, 1);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.125);
    var_out.o1 = float(0.25);
    var_out.o2 = float(0.5);
    var_out.o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat float i1;
    layout(location = 1, component = 2)  flat float i2;
    layout(location = 1, component = 3)  flat float i3;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), float(var_in.i1), float(var_in.i2), float(var_in.i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.125);
    var_out.o1 = float(0.25);
    var_out.o2 = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0;
    layout(location = 2, component = 1)  flat float i1;
    layout(location = 2, component = 2)  flat vec2 i2;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), float(var_in.i1), vec2(var_in.i2));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.125);
    var_out.o1 = vec2(0.25, 0.5);
    var_out.o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float i0;
    layout(location = 3, component = 1)  flat vec2 i1;
    layout(location = 3, component = 3)  flat float i3;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), vec2(var_in.i1), float(var_in.i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.125, 0.25);
    var_out.o2 = float(0.5);
    var_out.o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat vec2 i0;
    layout(location = 4, component = 2)  flat float i2;
    layout(location = 4, component = 3)  flat float i3;
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0), float(var_in.i2), float(var_in.i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.125);
    var_out.o1 = vec3(0.25, 0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat vec3 i1;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), vec3(var_in.i1));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec3(0.125, 0.25, 0.5);
    var_out.o3 = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec3 i0;
    layout(location = 2, component = 3)  flat float i3;
}
var_in;
void main()
{
    dEQP_color = vec4(vec3(var_in.i0), float(var_in.i3));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.125, 0.25);
    var_out.o2 = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0;
    layout(location = 3, component = 2)  flat vec2 i2;
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0), vec2(var_in.i2));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.125);
    var_out.o1[2] = float(0.25);
    var_out.o2[2] = float(0.5);
    var_out.o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat float i1[3];
    layout(location = 4, component = 2)  flat float i2[3];
    layout(location = 4, component = 3)  flat float i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), float(var_in.i1[2]), float(var_in.i2[2]), float(var_in.i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.125);
    var_out.o1[2] = float(0.25);
    var_out.o2[2] = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0[3];
    layout(location = 1, component = 1)  flat float i1[3];
    layout(location = 1, component = 2)  flat vec2 i2[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), float(var_in.i1[2]), vec2(var_in.i2[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.125);
    var_out.o1[2] = vec2(0.25, 0.5);
    var_out.o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0[3];
    layout(location = 2, component = 1)  flat vec2 i1[3];
    layout(location = 2, component = 3)  flat float i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), vec2(var_in.i1[2]), float(var_in.i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.125, 0.25);
    var_out.o2[2] = float(0.5);
    var_out.o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0[3];
    layout(location = 3, component = 2)  flat float i2[3];
    layout(location = 3, component = 3)  flat float i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0[2]), float(var_in.i2[2]), float(var_in.i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.125);
    var_out.o1[2] = vec3(0.25, 0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat vec3 i1[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), vec3(var_in.i1[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec3(0.125, 0.25, 0.5);
    var_out.o3[2] = float(1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat vec3 i0[3];
    layout(location = 1, component = 3)  flat float i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec3(var_in.i0[2]), float(var_in.i3[2]));
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.125, 0.25);
    var_out.o2[2] = vec2(0.5, 1);
}
#version 450
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec2 i0[3];
    layout(location = 2, component = 2)  flat vec2 i2[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0[2]), vec2(var_in.i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.125);
    var_out.o1 = float16_t(0.25);
    var_out.o2 = float16_t(0.5);
    var_out.o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat float16_t i1;
    layout(location = 3, component = 2)  flat float16_t i2;
    layout(location = 3, component = 3)  flat float16_t i3;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), float(var_in.i1), float(var_in.i2), float(var_in.i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.125);
    var_out.o1 = float16_t(0.25);
    var_out.o2 = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0;
    layout(location = 4, component = 1)  flat float16_t i1;
    layout(location = 4, component = 2)  flat f16vec2 i2;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), float(var_in.i1), vec2(var_in.i2));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.125);
    var_out.o1 = f16vec2(0.25, 0.5);
    var_out.o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float16_t i0;
    layout(location = 1, component = 1)  flat f16vec2 i1;
    layout(location = 1, component = 3)  flat float16_t i3;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), vec2(var_in.i1), float(var_in.i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.125, 0.25);
    var_out.o2 = float16_t(0.5);
    var_out.o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f16vec2 i0;
    layout(location = 2, component = 2)  flat float16_t i2;
    layout(location = 2, component = 3)  flat float16_t i3;
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0), float(var_in.i2), float(var_in.i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.125);
    var_out.o1 = f16vec3(0.25, 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat f16vec3 i1;
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0), vec3(var_in.i1));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec3(0.125, 0.25, 0.5);
    var_out.o3 = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec3 i0;
    layout(location = 4, component = 3)  flat float16_t i3;
}
var_in;
void main()
{
    dEQP_color = vec4(vec3(var_in.i0), float(var_in.i3));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.125, 0.25);
    var_out.o2 = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0;
    layout(location = 1, component = 2)  flat f16vec2 i2;
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0), vec2(var_in.i2));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.125);
    var_out.o1[2] = float16_t(0.25);
    var_out.o2[2] = float16_t(0.5);
    var_out.o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat float16_t i1[3];
    layout(location = 2, component = 2)  flat float16_t i2[3];
    layout(location = 2, component = 3)  flat float16_t i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), float(var_in.i1[2]), float(var_in.i2[2]), float(var_in.i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.125);
    var_out.o1[2] = float16_t(0.25);
    var_out.o2[2] = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0[3];
    layout(location = 3, component = 1)  flat float16_t i1[3];
    layout(location = 3, component = 2)  flat f16vec2 i2[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), float(var_in.i1[2]), vec2(var_in.i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.125);
    var_out.o1[2] = f16vec2(0.25, 0.5);
    var_out.o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0[3];
    layout(location = 4, component = 1)  flat f16vec2 i1[3];
    layout(location = 4, component = 3)  flat float16_t i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), vec2(var_in.i1[2]), float(var_in.i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.125, 0.25);
    var_out.o2[2] = float16_t(0.5);
    var_out.o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0[3];
    layout(location = 1, component = 2)  flat float16_t i2[3];
    layout(location = 1, component = 3)  flat float16_t i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0[2]), float(var_in.i2[2]), float(var_in.i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.125);
    var_out.o1[2] = f16vec3(0.25, 0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat f16vec3 i1[3];
}
var_in;
void main()
{
    dEQP_color = vec4(float(var_in.i0[2]), vec3(var_in.i1[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec3(0.125, 0.25, 0.5);
    var_out.o3[2] = float16_t(1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat f16vec3 i0[3];
    layout(location = 3, component = 3)  flat float16_t i3[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec3(var_in.i0[2]), float(var_in.i3[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.125, 0.25);
    var_out.o2[2] = f16vec2(0.5, 1);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out vec4 dEQP_color;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec2 i0[3];
    layout(location = 4, component = 2)  flat f16vec2 i2[3];
}
var_in;
void main()
{
    dEQP_color = vec4(vec2(var_in.i0[2]), vec2(var_in.i2[2]));
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float64_t o0;
layout(location = 1, component = 2) out flat float64_t o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float64_t(0.0625);
    o2 = float64_t(0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat float64_t i0[3];
layout(location = 1, component = 2) in flat float64_t i2[3];
layout(triangles) in;

layout(location = 1, component = 0) out flat float64_t o0;
layout(location = 1, component = 2) out flat float64_t o2;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float64_t(2.0);
        o2 = i2[i] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f64vec2 o0;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f64vec2(0.0625, 0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat f64vec2 i0[3];
layout(triangles) in;

layout(location = 2, component = 0) out flat f64vec2 o0;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float64_t o0[3];
layout(location = 3, component = 2) out flat float64_t o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float64_t(0.0625);
    o2[2] = float64_t(0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat float64_t i0[3][3];
layout(location = 3, component = 2) in flat float64_t i2[3][3];
layout(triangles) in;

layout(location = 3, component = 0) out flat float64_t o0[3];
layout(location = 3, component = 2) out flat float64_t o2[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float64_t(2.0);
        o2[2] = i2[i][2] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f64vec2 o0[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f64vec2(0.0625, 0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat f64vec2 i0[3][3];
layout(triangles) in;

layout(location = 4, component = 0) out flat f64vec2 o0[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat float o1;
layout(location = 1, component = 2) out flat float o2;
layout(location = 1, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.0625);
    o1 = float(0.125);
    o2 = float(0.25);
    o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat float i0[3];
layout(location = 1, component = 1) in flat float i1[3];
layout(location = 1, component = 2) in flat float i2[3];
layout(location = 1, component = 3) in flat float i3[3];
layout(triangles) in;

layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat float o1;
layout(location = 1, component = 2) out flat float o2;
layout(location = 1, component = 3) out flat float o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o1 = i1[i] * float(2.0);
        o2 = i2[i] * float(2.0);
        o3 = i3[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0;
layout(location = 2, component = 1) out flat float o1;
layout(location = 2, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.0625);
    o1 = float(0.125);
    o2 = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat float i0[3];
layout(location = 2, component = 1) in flat float i1[3];
layout(location = 2, component = 2) in flat vec2 i2[3];
layout(triangles) in;

layout(location = 2, component = 0) out flat float o0;
layout(location = 2, component = 1) out flat float o1;
layout(location = 2, component = 2) out flat vec2 o2;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o1 = i1[i] * float(2.0);
        o2 = i2[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float o0;
layout(location = 3, component = 1) out flat vec2 o1;
layout(location = 3, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.0625);
    o1 = vec2(0.125, 0.25);
    o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat float i0[3];
layout(location = 3, component = 1) in flat vec2 i1[3];
layout(location = 3, component = 3) in flat float i3[3];
layout(triangles) in;

layout(location = 3, component = 0) out flat float o0;
layout(location = 3, component = 1) out flat vec2 o1;
layout(location = 3, component = 3) out flat float o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o1 = i1[i] * float(2.0);
        o3 = i3[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat vec2 o0;
layout(location = 4, component = 2) out flat float o2;
layout(location = 4, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.0625, 0.125);
    o2 = float(0.25);
    o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat vec2 i0[3];
layout(location = 4, component = 2) in flat float i2[3];
layout(location = 4, component = 3) in flat float i3[3];
layout(triangles) in;

layout(location = 4, component = 0) out flat vec2 o0;
layout(location = 4, component = 2) out flat float o2;
layout(location = 4, component = 3) out flat float o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o2 = i2[i] * float(2.0);
        o3 = i3[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.0625);
    o1 = vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat float i0[3];
layout(location = 1, component = 1) in flat vec3 i1[3];
layout(triangles) in;

layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat vec3 o1;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o1 = i1[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec3 o0;
layout(location = 2, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec3(0.0625, 0.125, 0.25);
    o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat vec3 i0[3];
layout(location = 2, component = 3) in flat float i3[3];
layout(triangles) in;

layout(location = 2, component = 0) out flat vec3 o0;
layout(location = 2, component = 3) out flat float o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o3 = i3[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0;
layout(location = 3, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.0625, 0.125);
    o2 = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat vec2 i0[3];
layout(location = 3, component = 2) in flat vec2 i2[3];
layout(triangles) in;

layout(location = 3, component = 0) out flat vec2 o0;
layout(location = 3, component = 2) out flat vec2 o2;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float(2.0);
        o2 = i2[i] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat float o1[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.0625);
    o1[2] = float(0.125);
    o2[2] = float(0.25);
    o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat float i0[3][3];
layout(location = 4, component = 1) in flat float i1[3][3];
layout(location = 4, component = 2) in flat float i2[3][3];
layout(location = 4, component = 3) in flat float i3[3][3];
layout(triangles) in;

layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat float o1[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o1[2] = i1[i][2] * float(2.0);
        o2[2] = i2[i][2] * float(2.0);
        o3[2] = i3[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.0625);
    o1[2] = float(0.125);
    o2[2] = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat float i0[3][3];
layout(location = 1, component = 1) in flat float i1[3][3];
layout(location = 1, component = 2) in flat vec2 i2[3][3];
layout(triangles) in;

layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat vec2 o2[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o1[2] = i1[i][2] * float(2.0);
        o2[2] = i2[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat vec2 o1[3];
layout(location = 2, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.0625);
    o1[2] = vec2(0.125, 0.25);
    o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat float i0[3][3];
layout(location = 2, component = 1) in flat vec2 i1[3][3];
layout(location = 2, component = 3) in flat float i3[3][3];
layout(triangles) in;

layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat vec2 o1[3];
layout(location = 2, component = 3) out flat float o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o1[2] = i1[i][2] * float(2.0);
        o3[2] = i3[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat float o2[3];
layout(location = 3, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.0625, 0.125);
    o2[2] = float(0.25);
    o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat vec2 i0[3][3];
layout(location = 3, component = 2) in flat float i2[3][3];
layout(location = 3, component = 3) in flat float i3[3][3];
layout(triangles) in;

layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat float o2[3];
layout(location = 3, component = 3) out flat float o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o2[2] = i2[i][2] * float(2.0);
        o3[2] = i3[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.0625);
    o1[2] = vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat float i0[3][3];
layout(location = 4, component = 1) in flat vec3 i1[3][3];
layout(triangles) in;

layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat vec3 o1[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o1[2] = i1[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat vec3 o0[3];
layout(location = 1, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec3(0.0625, 0.125, 0.25);
    o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat vec3 i0[3][3];
layout(location = 1, component = 3) in flat float i3[3][3];
layout(triangles) in;

layout(location = 1, component = 0) out flat vec3 o0[3];
layout(location = 1, component = 3) out flat float o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o3[2] = i3[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec2 o0[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.0625, 0.125);
    o2[2] = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat vec2 i0[3][3];
layout(location = 2, component = 2) in flat vec2 i2[3][3];
layout(triangles) in;

layout(location = 2, component = 0) out flat vec2 o0[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float(2.0);
        o2[2] = i2[i][2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat float16_t o1;
layout(location = 3, component = 2) out flat float16_t o2;
layout(location = 3, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.0625);
    o1 = float16_t(0.125);
    o2 = float16_t(0.25);
    o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat float16_t i0[3];
layout(location = 3, component = 1) in flat float16_t i1[3];
layout(location = 3, component = 2) in flat float16_t i2[3];
layout(location = 3, component = 3) in flat float16_t i3[3];
layout(triangles) in;

layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat float16_t o1;
layout(location = 3, component = 2) out flat float16_t o2;
layout(location = 3, component = 3) out flat float16_t o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o1 = i1[i] * float16_t(2.0);
        o2 = i2[i] * float16_t(2.0);
        o3 = i3[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0;
layout(location = 4, component = 1) out flat float16_t o1;
layout(location = 4, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.0625);
    o1 = float16_t(0.125);
    o2 = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat float16_t i0[3];
layout(location = 4, component = 1) in flat float16_t i1[3];
layout(location = 4, component = 2) in flat f16vec2 i2[3];
layout(triangles) in;

layout(location = 4, component = 0) out flat float16_t o0;
layout(location = 4, component = 1) out flat float16_t o1;
layout(location = 4, component = 2) out flat f16vec2 o2;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o1 = i1[i] * float16_t(2.0);
        o2 = i2[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float16_t o0;
layout(location = 1, component = 1) out flat f16vec2 o1;
layout(location = 1, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.0625);
    o1 = f16vec2(0.125, 0.25);
    o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat float16_t i0[3];
layout(location = 1, component = 1) in flat f16vec2 i1[3];
layout(location = 1, component = 3) in flat float16_t i3[3];
layout(triangles) in;

layout(location = 1, component = 0) out flat float16_t o0;
layout(location = 1, component = 1) out flat f16vec2 o1;
layout(location = 1, component = 3) out flat float16_t o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o1 = i1[i] * float16_t(2.0);
        o3 = i3[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f16vec2 o0;
layout(location = 2, component = 2) out flat float16_t o2;
layout(location = 2, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.0625, 0.125);
    o2 = float16_t(0.25);
    o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat f16vec2 i0[3];
layout(location = 2, component = 2) in flat float16_t i2[3];
layout(location = 2, component = 3) in flat float16_t i3[3];
layout(triangles) in;

layout(location = 2, component = 0) out flat f16vec2 o0;
layout(location = 2, component = 2) out flat float16_t o2;
layout(location = 2, component = 3) out flat float16_t o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o2 = i2[i] * float16_t(2.0);
        o3 = i3[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat f16vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.0625);
    o1 = f16vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat float16_t i0[3];
layout(location = 3, component = 1) in flat f16vec3 i1[3];
layout(triangles) in;

layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat f16vec3 o1;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o1 = i1[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec3 o0;
layout(location = 4, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec3(0.0625, 0.125, 0.25);
    o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat f16vec3 i0[3];
layout(location = 4, component = 3) in flat float16_t i3[3];
layout(triangles) in;

layout(location = 4, component = 0) out flat f16vec3 o0;
layout(location = 4, component = 3) out flat float16_t o3;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o3 = i3[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0;
layout(location = 1, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.0625, 0.125);
    o2 = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat f16vec2 i0[3];
layout(location = 1, component = 2) in flat f16vec2 i2[3];
layout(triangles) in;

layout(location = 1, component = 0) out flat f16vec2 o0;
layout(location = 1, component = 2) out flat f16vec2 o2;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0 = i0[i] * float16_t(2.0);
        o2 = i2[i] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat float16_t o1[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.0625);
    o1[2] = float16_t(0.125);
    o2[2] = float16_t(0.25);
    o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat float16_t i0[3][3];
layout(location = 2, component = 1) in flat float16_t i1[3][3];
layout(location = 2, component = 2) in flat float16_t i2[3][3];
layout(location = 2, component = 3) in flat float16_t i3[3][3];
layout(triangles) in;

layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat float16_t o1[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o1[2] = i1[i][2] * float16_t(2.0);
        o2[2] = i2[i][2] * float16_t(2.0);
        o3[2] = i3[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.0625);
    o1[2] = float16_t(0.125);
    o2[2] = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat float16_t i0[3][3];
layout(location = 3, component = 1) in flat float16_t i1[3][3];
layout(location = 3, component = 2) in flat f16vec2 i2[3][3];
layout(triangles) in;

layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat f16vec2 o2[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o1[2] = i1[i][2] * float16_t(2.0);
        o2[2] = i2[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat f16vec2 o1[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.0625);
    o1[2] = f16vec2(0.125, 0.25);
    o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat float16_t i0[3][3];
layout(location = 4, component = 1) in flat f16vec2 i1[3][3];
layout(location = 4, component = 3) in flat float16_t i3[3][3];
layout(triangles) in;

layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat f16vec2 o1[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o1[2] = i1[i][2] * float16_t(2.0);
        o3[2] = i3[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat float16_t o2[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.0625, 0.125);
    o2[2] = float16_t(0.25);
    o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1, component = 0) in flat f16vec2 i0[3][3];
layout(location = 1, component = 2) in flat float16_t i2[3][3];
layout(location = 1, component = 3) in flat float16_t i3[3][3];
layout(triangles) in;

layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat float16_t o2[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o2[2] = i2[i][2] * float16_t(2.0);
        o3[2] = i3[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat f16vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.0625);
    o1[2] = f16vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2, component = 0) in flat float16_t i0[3][3];
layout(location = 2, component = 1) in flat f16vec3 i1[3][3];
layout(triangles) in;

layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat f16vec3 o1[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o1[2] = i1[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat f16vec3 o0[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec3(0.0625, 0.125, 0.25);
    o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3, component = 0) in flat f16vec3 i0[3][3];
layout(location = 3, component = 3) in flat float16_t i3[3][3];
layout(triangles) in;

layout(location = 3, component = 0) out flat f16vec3 o0[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o3[2] = i3[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec2 o0[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.0625, 0.125);
    o2[2] = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4, component = 0) in flat f16vec2 i0[3][3];
layout(location = 4, component = 2) in flat f16vec2 i2[3][3];
layout(triangles) in;

layout(location = 4, component = 0) out flat f16vec2 o0[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        o0[2] = i0[i][2] * float16_t(2.0);
        o2[2] = i2[i][2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float64_t(0.0625);
    var_out.o2 = float64_t(0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float64_t i0;
    layout(location = 1, component = 2)  flat float64_t i2;
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float64_t(2.0);
        var_out.o2 = var_in[i].i2 * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f64vec2(0.0625, 0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f64vec2 i0;
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float64_t(0.0625);
    var_out.o2[2] = float64_t(0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float64_t i0[3];
    layout(location = 3, component = 2)  flat float64_t i2[3];
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float64_t(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f64vec2(0.0625, 0.125);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f64vec2 i0[3];
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float64_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.0625);
    var_out.o1 = float(0.125);
    var_out.o2 = float(0.25);
    var_out.o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat float i1;
    layout(location = 1, component = 2)  flat float i2;
    layout(location = 1, component = 3)  flat float i3;
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o1 = var_in[i].i1 * float(2.0);
        var_out.o2 = var_in[i].i2 * float(2.0);
        var_out.o3 = var_in[i].i3 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.0625);
    var_out.o1 = float(0.125);
    var_out.o2 = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0;
    layout(location = 2, component = 1)  flat float i1;
    layout(location = 2, component = 2)  flat vec2 i2;
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o1 = var_in[i].i1 * float(2.0);
        var_out.o2 = var_in[i].i2 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.0625);
    var_out.o1 = vec2(0.125, 0.25);
    var_out.o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float i0;
    layout(location = 3, component = 1)  flat vec2 i1;
    layout(location = 3, component = 3)  flat float i3;
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o1 = var_in[i].i1 * float(2.0);
        var_out.o3 = var_in[i].i3 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.0625, 0.125);
    var_out.o2 = float(0.25);
    var_out.o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat vec2 i0;
    layout(location = 4, component = 2)  flat float i2;
    layout(location = 4, component = 3)  flat float i3;
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o2 = var_in[i].i2 * float(2.0);
        var_out.o3 = var_in[i].i3 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.0625);
    var_out.o1 = vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat vec3 i1;
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o1 = var_in[i].i1 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec3(0.0625, 0.125, 0.25);
    var_out.o3 = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec3 i0;
    layout(location = 2, component = 3)  flat float i3;
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o3 = var_in[i].i3 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.0625, 0.125);
    var_out.o2 = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0;
    layout(location = 3, component = 2)  flat vec2 i2;
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float(2.0);
        var_out.o2 = var_in[i].i2 * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.0625);
    var_out.o1[2] = float(0.125);
    var_out.o2[2] = float(0.25);
    var_out.o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat float i1[3];
    layout(location = 4, component = 2)  flat float i2[3];
    layout(location = 4, component = 3)  flat float i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.0625);
    var_out.o1[2] = float(0.125);
    var_out.o2[2] = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0[3];
    layout(location = 1, component = 1)  flat float i1[3];
    layout(location = 1, component = 2)  flat vec2 i2[3];
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.0625);
    var_out.o1[2] = vec2(0.125, 0.25);
    var_out.o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0[3];
    layout(location = 2, component = 1)  flat vec2 i1[3];
    layout(location = 2, component = 3)  flat float i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.0625, 0.125);
    var_out.o2[2] = float(0.25);
    var_out.o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0[3];
    layout(location = 3, component = 2)  flat float i2[3];
    layout(location = 3, component = 3)  flat float i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.0625);
    var_out.o1[2] = vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat vec3 i1[3];
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec3(0.0625, 0.125, 0.25);
    var_out.o3[2] = float(0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat vec3 i0[3];
    layout(location = 1, component = 3)  flat float i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.0625, 0.125);
    var_out.o2[2] = vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec2 i0[3];
    layout(location = 2, component = 2)  flat vec2 i2[3];
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.0625);
    var_out.o1 = float16_t(0.125);
    var_out.o2 = float16_t(0.25);
    var_out.o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat float16_t i1;
    layout(location = 3, component = 2)  flat float16_t i2;
    layout(location = 3, component = 3)  flat float16_t i3;
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o1 = var_in[i].i1 * float16_t(2.0);
        var_out.o2 = var_in[i].i2 * float16_t(2.0);
        var_out.o3 = var_in[i].i3 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.0625);
    var_out.o1 = float16_t(0.125);
    var_out.o2 = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0;
    layout(location = 4, component = 1)  flat float16_t i1;
    layout(location = 4, component = 2)  flat f16vec2 i2;
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o1 = var_in[i].i1 * float16_t(2.0);
        var_out.o2 = var_in[i].i2 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.0625);
    var_out.o1 = f16vec2(0.125, 0.25);
    var_out.o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float16_t i0;
    layout(location = 1, component = 1)  flat f16vec2 i1;
    layout(location = 1, component = 3)  flat float16_t i3;
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o1 = var_in[i].i1 * float16_t(2.0);
        var_out.o3 = var_in[i].i3 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.0625, 0.125);
    var_out.o2 = float16_t(0.25);
    var_out.o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f16vec2 i0;
    layout(location = 2, component = 2)  flat float16_t i2;
    layout(location = 2, component = 3)  flat float16_t i3;
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o2 = var_in[i].i2 * float16_t(2.0);
        var_out.o3 = var_in[i].i3 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.0625);
    var_out.o1 = f16vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat f16vec3 i1;
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o1 = var_in[i].i1 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec3(0.0625, 0.125, 0.25);
    var_out.o3 = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec3 i0;
    layout(location = 4, component = 3)  flat float16_t i3;
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o3 = var_in[i].i3 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.0625, 0.125);
    var_out.o2 = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0;
    layout(location = 1, component = 2)  flat f16vec2 i2;
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0 = var_in[i].i0 * float16_t(2.0);
        var_out.o2 = var_in[i].i2 * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.0625);
    var_out.o1[2] = float16_t(0.125);
    var_out.o2[2] = float16_t(0.25);
    var_out.o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat float16_t i1[3];
    layout(location = 2, component = 2)  flat float16_t i2[3];
    layout(location = 2, component = 3)  flat float16_t i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float16_t(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float16_t(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.0625);
    var_out.o1[2] = float16_t(0.125);
    var_out.o2[2] = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0[3];
    layout(location = 3, component = 1)  flat float16_t i1[3];
    layout(location = 3, component = 2)  flat f16vec2 i2[3];
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float16_t(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.0625);
    var_out.o1[2] = f16vec2(0.125, 0.25);
    var_out.o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0[3];
    layout(location = 4, component = 1)  flat f16vec2 i1[3];
    layout(location = 4, component = 3)  flat float16_t i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float16_t(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.0625, 0.125);
    var_out.o2[2] = float16_t(0.25);
    var_out.o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0[3];
    layout(location = 1, component = 2)  flat float16_t i2[3];
    layout(location = 1, component = 3)  flat float16_t i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float16_t(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.0625);
    var_out.o1[2] = f16vec3(0.125, 0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat f16vec3 i1[3];
}
var_in[3];
layout(triangles) in;

layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o1[2] = var_in[i].i1[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec3(0.0625, 0.125, 0.25);
    var_out.o3[2] = float16_t(0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat f16vec3 i0[3];
    layout(location = 3, component = 3)  flat float16_t i3[3];
}
var_in[3];
layout(triangles) in;

layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o3[2] = var_in[i].i3[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.0625, 0.125);
    var_out.o2[2] = f16vec2(0.25, 0.5);
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_geometry_shader : require

layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec2 i0[3];
    layout(location = 4, component = 2)  flat f16vec2 i2[3];
}
var_in[3];
layout(triangles) in;

layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out;
layout(triangle_strip, max_vertices = 3) out;

void main()
{
    for (uint i = 0; i < 3; ++i)
    {
        gl_Position = gl_in[i].gl_Position;
        var_out.o0[2] = var_in[i].i0[2] * float16_t(2.0);
        var_out.o2[2] = var_in[i].i2[2] * float16_t(2.0);
        EmitVertex();
    }
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat float64_t i0[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat float64_t i2[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float64_t o0[3];
layout(location = 1, component = 2) out flat float64_t o2[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat float64_t i0[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat float64_t i2[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float64_t o0;
layout(location = 1, component = 2) out flat float64_t o2;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float64_t(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat f64vec2 i0[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat f64vec2 o0[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat f64vec2 i0[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat f64vec2 o0;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat float64_t i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat float64_t i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat float64_t o0[3][3];
layout(location = 3, component = 2) out flat float64_t o2[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat float64_t i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat float64_t i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat float64_t o0[3];
layout(location = 3, component = 2) out flat float64_t o2[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float64_t(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat f64vec2 i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat f64vec2 o0[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat f64vec2 i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat f64vec2 o0[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float64_t(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat float i1[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat float i2[gl_MaxPatchVertices];
layout(location = 1, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat float o2[3];
layout(location = 1, component = 3) out flat float o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat float i1[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat float i2[gl_MaxPatchVertices];
layout(location = 1, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat float o1;
layout(location = 1, component = 2) out flat float o2;
layout(location = 1, component = 3) out flat float o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 2, component = 1) in flat float i1[gl_MaxPatchVertices];
layout(location = 2, component = 2) in flat vec2 i2[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat float o1[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 2, component = 1) in flat float i1[gl_MaxPatchVertices];
layout(location = 2, component = 2) in flat vec2 i2[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat float o0;
layout(location = 2, component = 1) out flat float o1;
layout(location = 2, component = 2) out flat vec2 o2;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat vec2 i1[gl_MaxPatchVertices];
layout(location = 3, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float o0[3];
layout(location = 3, component = 1) out flat vec2 o1[3];
layout(location = 3, component = 3) out flat float o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat vec2 i1[gl_MaxPatchVertices];
layout(location = 3, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float o0;
layout(location = 3, component = 1) out flat vec2 o1;
layout(location = 3, component = 3) out flat float o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat vec2 i0[gl_MaxPatchVertices];
layout(location = 4, component = 2) in flat float i2[gl_MaxPatchVertices];
layout(location = 4, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat vec2 o0[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat vec2 i0[gl_MaxPatchVertices];
layout(location = 4, component = 2) in flat float i2[gl_MaxPatchVertices];
layout(location = 4, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat vec2 o0;
layout(location = 4, component = 2) out flat float o2;
layout(location = 4, component = 3) out flat float o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat vec3 i1[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat vec3 o1[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat vec3 i1[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat vec3 o1;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat vec3 i0[gl_MaxPatchVertices];
layout(location = 2, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat vec3 o0[3];
layout(location = 2, component = 3) out flat float o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat vec3 i0[gl_MaxPatchVertices];
layout(location = 2, component = 3) in flat float i3[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat vec3 o0;
layout(location = 2, component = 3) out flat float o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat vec2 i0[gl_MaxPatchVertices];
layout(location = 3, component = 2) in flat vec2 i2[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat vec2 o2[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat vec2 i0[gl_MaxPatchVertices];
layout(location = 3, component = 2) in flat vec2 i2[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat vec2 o0;
layout(location = 3, component = 2) out flat vec2 o2;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat float i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 2) in flat float i2[gl_MaxPatchVertices][3];
layout(location = 4, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float o0[3][3];
layout(location = 4, component = 1) out flat float o1[3][3];
layout(location = 4, component = 2) out flat float o2[3][3];
layout(location = 4, component = 3) out flat float o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat float i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 2) in flat float i2[gl_MaxPatchVertices][3];
layout(location = 4, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat float o1[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 1) in flat float i1[gl_MaxPatchVertices][3];
layout(location = 1, component = 2) in flat vec2 i2[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat float o0[3][3];
layout(location = 1, component = 1) out flat float o1[3][3];
layout(location = 1, component = 2) out flat vec2 o2[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 1) in flat float i1[gl_MaxPatchVertices][3];
layout(location = 1, component = 2) in flat vec2 i2[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat vec2 o2[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat vec2 i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float o0[3][3];
layout(location = 2, component = 1) out flat vec2 o1[3][3];
layout(location = 2, component = 3) out flat float o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat vec2 i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat vec2 o1[3];
layout(location = 2, component = 3) out flat float o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat vec2 i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat float i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat vec2 o0[3][3];
layout(location = 3, component = 2) out flat float o2[3][3];
layout(location = 3, component = 3) out flat float o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat vec2 i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat float i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat float o2[3];
layout(location = 3, component = 3) out flat float o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat vec3 i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float o0[3][3];
layout(location = 4, component = 1) out flat vec3 o1[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat float i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat vec3 i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat vec3 o1[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat vec3 i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat vec3 o0[3][3];
layout(location = 1, component = 3) out flat float o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat vec3 i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 3) in flat float i3[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat vec3 o0[3];
layout(location = 1, component = 3) out flat float o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat vec2 i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 2) in flat vec2 i2[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat vec2 o0[3][3];
layout(location = 2, component = 2) out flat vec2 o2[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat vec2 i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 2) in flat vec2 i2[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat vec2 o0[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat float16_t i1[gl_MaxPatchVertices];
layout(location = 3, component = 2) in flat float16_t i2[gl_MaxPatchVertices];
layout(location = 3, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat float16_t o2[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat float16_t i1[gl_MaxPatchVertices];
layout(location = 3, component = 2) in flat float16_t i2[gl_MaxPatchVertices];
layout(location = 3, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat float16_t o1;
layout(location = 3, component = 2) out flat float16_t o2;
layout(location = 3, component = 3) out flat float16_t o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float16_t(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float16_t(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 4, component = 1) in flat float16_t i1[gl_MaxPatchVertices];
layout(location = 4, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat float16_t o1[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 4, component = 1) in flat float16_t i1[gl_MaxPatchVertices];
layout(location = 4, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat float16_t o0;
layout(location = 4, component = 1) out flat float16_t o1;
layout(location = 4, component = 2) out flat f16vec2 o2;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float16_t(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat f16vec2 i1[gl_MaxPatchVertices];
layout(location = 1, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float16_t o0[3];
layout(location = 1, component = 1) out flat f16vec2 o1[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 1, component = 1) in flat f16vec2 i1[gl_MaxPatchVertices];
layout(location = 1, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat float16_t o0;
layout(location = 1, component = 1) out flat f16vec2 o1;
layout(location = 1, component = 3) out flat float16_t o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float16_t(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices];
layout(location = 2, component = 2) in flat float16_t i2[gl_MaxPatchVertices];
layout(location = 2, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat f16vec2 o0[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices];
layout(location = 2, component = 2) in flat float16_t i2[gl_MaxPatchVertices];
layout(location = 2, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 2, component = 0) out flat f16vec2 o0;
layout(location = 2, component = 2) out flat float16_t o2;
layout(location = 2, component = 3) out flat float16_t o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float16_t(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat f16vec3 i1[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat f16vec3 o1[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o1[gl_InvocationID] = i1[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices];
layout(location = 3, component = 1) in flat f16vec3 i1[gl_MaxPatchVertices];
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat f16vec3 o1;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o1 = (i1[0] + i1[1] + i1[2] + i1[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat f16vec3 i0[gl_MaxPatchVertices];
layout(location = 4, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat f16vec3 o0[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o3[gl_InvocationID] = i3[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat f16vec3 i0[gl_MaxPatchVertices];
layout(location = 4, component = 3) in flat float16_t i3[gl_MaxPatchVertices];
layout(location = 4, component = 0) out flat f16vec3 o0;
layout(location = 4, component = 3) out flat float16_t o3;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o3 = (i3[0] + i3[1] + i3[2] + i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID] = i0[gl_InvocationID];
    o2[gl_InvocationID] = i2[gl_InvocationID];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices];
layout(location = 1, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices];
layout(location = 1, component = 0) out flat f16vec2 o0;
layout(location = 1, component = 2) out flat f16vec2 o2;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0 = (i0[0] + i0[1] + i0[2] + i0[2]) / float16_t(2);
    o2 = (i2[0] + i2[1] + i2[2] + i2[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat float16_t i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 2) in flat float16_t i2[gl_MaxPatchVertices][3];
layout(location = 2, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float16_t o0[3][3];
layout(location = 2, component = 1) out flat float16_t o1[3][3];
layout(location = 2, component = 2) out flat float16_t o2[3][3];
layout(location = 2, component = 3) out flat float16_t o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat float16_t i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 2) in flat float16_t i2[gl_MaxPatchVertices][3];
layout(location = 2, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat float16_t o1[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float16_t(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float16_t(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 1) in flat float16_t i1[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat float16_t o0[3][3];
layout(location = 3, component = 1) out flat float16_t o1[3][3];
layout(location = 3, component = 2) out flat f16vec2 o2[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 1) in flat float16_t i1[gl_MaxPatchVertices][3];
layout(location = 3, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat f16vec2 o2[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float16_t(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat f16vec2 i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float16_t o0[3][3];
layout(location = 4, component = 1) out flat f16vec2 o1[3][3];
layout(location = 4, component = 3) out flat float16_t o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 1) in flat f16vec2 i1[gl_MaxPatchVertices][3];
layout(location = 4, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat f16vec2 o1[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float16_t(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 2) in flat float16_t i2[gl_MaxPatchVertices][3];
layout(location = 1, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat f16vec2 o0[3][3];
layout(location = 1, component = 2) out flat float16_t o2[3][3];
layout(location = 1, component = 3) out flat float16_t o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices][3];
layout(location = 1, component = 2) in flat float16_t i2[gl_MaxPatchVertices][3];
layout(location = 1, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat float16_t o2[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float16_t(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat f16vec3 i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float16_t o0[3][3];
layout(location = 2, component = 1) out flat f16vec3 o1[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o1[gl_InvocationID][2] = i1[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2, component = 0) in flat float16_t i0[gl_MaxPatchVertices][3];
layout(location = 2, component = 1) in flat f16vec3 i1[gl_MaxPatchVertices][3];
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat f16vec3 o1[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o1[2] = (i1[0][2] + i1[1][2] + i1[2][2] + i1[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3, component = 0) in flat f16vec3 i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat f16vec3 o0[3][3];
layout(location = 3, component = 3) out flat float16_t o3[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o3[gl_InvocationID][2] = i3[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3, component = 0) in flat f16vec3 i0[gl_MaxPatchVertices][3];
layout(location = 3, component = 3) in flat float16_t i3[gl_MaxPatchVertices][3];
layout(location = 3, component = 0) out flat f16vec3 o0[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o3[2] = (i3[0][2] + i3[1][2] + i3[2][2] + i3[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat f16vec2 o0[3][3];
layout(location = 4, component = 2) out flat f16vec2 o2[3][3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    o0[gl_InvocationID][2] = i0[gl_InvocationID][2];
    o2[gl_InvocationID][2] = i2[gl_InvocationID][2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4, component = 0) in flat f16vec2 i0[gl_MaxPatchVertices][3];
layout(location = 4, component = 2) in flat f16vec2 i2[gl_MaxPatchVertices][3];
layout(location = 4, component = 0) out flat f16vec2 o0[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    o0[2] = (i0[0][2] + i0[1][2] + i0[2][2] + i0[2][2]) / float16_t(2);
    o2[2] = (i2[0][2] + i2[1][2] + i2[2][2] + i2[2][2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float64_t i0;
    layout(location = 1, component = 2)  flat float64_t i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float64_t i0;
    layout(location = 1, component = 2)  flat float64_t i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float64_t(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f64vec2 i0;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f64vec2 i0;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float64_t i0[3];
    layout(location = 3, component = 2)  flat float64_t i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float64_t i0[3];
    layout(location = 3, component = 2)  flat float64_t i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float64_t(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float64_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f64vec2 i0[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f64vec2 i0[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float64_t(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat float i1;
    layout(location = 1, component = 2)  flat float i2;
    layout(location = 1, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat float i1;
    layout(location = 1, component = 2)  flat float i2;
    layout(location = 1, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0;
    layout(location = 2, component = 1)  flat float i1;
    layout(location = 2, component = 2)  flat vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0;
    layout(location = 2, component = 1)  flat float i1;
    layout(location = 2, component = 2)  flat vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float i0;
    layout(location = 3, component = 1)  flat vec2 i1;
    layout(location = 3, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float i0;
    layout(location = 3, component = 1)  flat vec2 i1;
    layout(location = 3, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat vec2 i0;
    layout(location = 4, component = 2)  flat float i2;
    layout(location = 4, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat vec2 i0;
    layout(location = 4, component = 2)  flat float i2;
    layout(location = 4, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat vec3 i1;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0;
    layout(location = 1, component = 1)  flat vec3 i1;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec3 i0;
    layout(location = 2, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec3 i0;
    layout(location = 2, component = 3)  flat float i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0;
    layout(location = 3, component = 2)  flat vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0;
    layout(location = 3, component = 2)  flat vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat float i1[3];
    layout(location = 4, component = 2)  flat float i2[3];
    layout(location = 4, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat float i1[3];
    layout(location = 4, component = 2)  flat float i2[3];
    layout(location = 4, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0[3];
    layout(location = 1, component = 1)  flat float i1[3];
    layout(location = 1, component = 2)  flat vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float i0[3];
    layout(location = 1, component = 1)  flat float i1[3];
    layout(location = 1, component = 2)  flat vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0[3];
    layout(location = 2, component = 1)  flat vec2 i1[3];
    layout(location = 2, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float i0[3];
    layout(location = 2, component = 1)  flat vec2 i1[3];
    layout(location = 2, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0[3];
    layout(location = 3, component = 2)  flat float i2[3];
    layout(location = 3, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat vec2 i0[3];
    layout(location = 3, component = 2)  flat float i2[3];
    layout(location = 3, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat vec3 i1[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float i0[3];
    layout(location = 4, component = 1)  flat vec3 i1[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat vec3 i0[3];
    layout(location = 1, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat vec3 i0[3];
    layout(location = 1, component = 3)  flat float i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float(2);
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec2 i0[3];
    layout(location = 2, component = 2)  flat vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat vec2 i0[3];
    layout(location = 2, component = 2)  flat vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat float16_t i1;
    layout(location = 3, component = 2)  flat float16_t i2;
    layout(location = 3, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat float16_t i1;
    layout(location = 3, component = 2)  flat float16_t i2;
    layout(location = 3, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float16_t(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float16_t(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0;
    layout(location = 4, component = 1)  flat float16_t i1;
    layout(location = 4, component = 2)  flat f16vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0;
    layout(location = 4, component = 1)  flat float16_t i1;
    layout(location = 4, component = 2)  flat f16vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float16_t(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float16_t i0;
    layout(location = 1, component = 1)  flat f16vec2 i1;
    layout(location = 1, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat float16_t i0;
    layout(location = 1, component = 1)  flat f16vec2 i1;
    layout(location = 1, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float16_t(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f16vec2 i0;
    layout(location = 2, component = 2)  flat float16_t i2;
    layout(location = 2, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat f16vec2 i0;
    layout(location = 2, component = 2)  flat float16_t i2;
    layout(location = 2, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float16_t(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat f16vec3 i1;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o1 = var_in[gl_InvocationID].i1;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0;
    layout(location = 3, component = 1)  flat f16vec3 i1;
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o1 = (var_in[0].i1  +  var_in[1].i1  +  var_in[2].i1  +  var_in[2].i1) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec3 i0;
    layout(location = 4, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o3 = var_in[gl_InvocationID].i3;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec3 i0;
    layout(location = 4, component = 3)  flat float16_t i3;
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o3 = (var_in[0].i3  +  var_in[1].i3  +  var_in[2].i3  +  var_in[2].i3) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0;
    layout(location = 1, component = 2)  flat f16vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0 = var_in[gl_InvocationID].i0;
    var_out[gl_InvocationID].o2 = var_in[gl_InvocationID].i2;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0;
    layout(location = 1, component = 2)  flat f16vec2 i2;
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0 = (var_in[0].i0  +  var_in[1].i0  +  var_in[2].i0  +  var_in[2].i0) / float16_t(2);
    var_out.o2 = (var_in[0].i2  +  var_in[1].i2  +  var_in[2].i2  +  var_in[2].i2) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat float16_t i1[3];
    layout(location = 2, component = 2)  flat float16_t i2[3];
    layout(location = 2, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat float16_t i1[3];
    layout(location = 2, component = 2)  flat float16_t i2[3];
    layout(location = 2, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float16_t(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float16_t(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0[3];
    layout(location = 3, component = 1)  flat float16_t i1[3];
    layout(location = 3, component = 2)  flat f16vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat float16_t i0[3];
    layout(location = 3, component = 1)  flat float16_t i1[3];
    layout(location = 3, component = 2)  flat f16vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float16_t(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0[3];
    layout(location = 4, component = 1)  flat f16vec2 i1[3];
    layout(location = 4, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat float16_t i0[3];
    layout(location = 4, component = 1)  flat f16vec2 i1[3];
    layout(location = 4, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float16_t(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0[3];
    layout(location = 1, component = 2)  flat float16_t i2[3];
    layout(location = 1, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 1) in In
{
    layout(location = 1, component = 0)  flat f16vec2 i0[3];
    layout(location = 1, component = 2)  flat float16_t i2[3];
    layout(location = 1, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float16_t(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat f16vec3 i1[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o1[2] = var_in[gl_InvocationID].i1[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 2) in In
{
    layout(location = 2, component = 0)  flat float16_t i0[3];
    layout(location = 2, component = 1)  flat f16vec3 i1[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o1[2] = (var_in[0].i1[2]  +  var_in[1].i1[2]  +  var_in[2].i1[2]  +  var_in[2].i1[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat f16vec3 i0[3];
    layout(location = 3, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o3[2] = var_in[gl_InvocationID].i3[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 3) in In
{
    layout(location = 3, component = 0)  flat f16vec3 i0[3];
    layout(location = 3, component = 3)  flat float16_t i3[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o3[2] = (var_in[0].i3[2]  +  var_in[1].i3[2]  +  var_in[2].i3[2]  +  var_in[2].i3[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(vertices = 3) out;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec2 i0[3];
    layout(location = 4, component = 2)  flat f16vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out[3];
void main()
{
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 6.0;
    gl_TessLevelOuter[3] = 8.0;
    gl_TessLevelInner[0] = 8.0;
    gl_TessLevelInner[1] = 8.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    var_out[gl_InvocationID].o0[2] = var_in[gl_InvocationID].i0[2];
    var_out[gl_InvocationID].o2[2] = var_in[gl_InvocationID].i2[2];
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
#extension GL_EXT_tessellation_shader : require
layout(triangles, cw) in;
layout(location = 4) in In
{
    layout(location = 4, component = 0)  flat f16vec2 i0[3];
    layout(location = 4, component = 2)  flat f16vec2 i2[3];
}
var_in[gl_MaxPatchVertices];
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float w = gl_TessCoord.z;
    vec4 pos0 = gl_in[0].gl_Position;
    vec4 pos1 = gl_in[1].gl_Position;
    vec4 pos2 = gl_in[2].gl_Position;
    gl_Position = u * pos0 + v * pos1 + w * pos2;

    var_out.o0[2] = (var_in[0].i0[2]  +  var_in[1].i0[2]  +  var_in[2].i0[2]  +  var_in[2].i0[2]) / float16_t(2);
    var_out.o2[2] = (var_in[0].i2[2]  +  var_in[1].i2[2]  +  var_in[2].i2[2]  +  var_in[2].i2[2]) / float16_t(2);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float64_t o0;
layout(location = 1, component = 2) out flat float64_t o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float64_t(0.03125);
    o2 = float64_t(0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f64vec2 o0;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f64vec2(0.03125, 0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float64_t o0[3];
layout(location = 3, component = 2) out flat float64_t o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float64_t(0.03125);
    o2[2] = float64_t(0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f64vec2 o0[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f64vec2(0.03125, 0.0625);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat float o1;
layout(location = 1, component = 2) out flat float o2;
layout(location = 1, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.03125);
    o1 = float(0.0625);
    o2 = float(0.125);
    o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0;
layout(location = 2, component = 1) out flat float o1;
layout(location = 2, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.03125);
    o1 = float(0.0625);
    o2 = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float o0;
layout(location = 3, component = 1) out flat vec2 o1;
layout(location = 3, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.03125);
    o1 = vec2(0.0625, 0.125);
    o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat vec2 o0;
layout(location = 4, component = 2) out flat float o2;
layout(location = 4, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.03125, 0.0625);
    o2 = float(0.125);
    o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0;
layout(location = 1, component = 1) out flat vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float(0.03125);
    o1 = vec3(0.0625, 0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec3 o0;
layout(location = 2, component = 3) out flat float o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec3(0.03125, 0.0625, 0.125);
    o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0;
layout(location = 3, component = 2) out flat vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = vec2(0.03125, 0.0625);
    o2 = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat float o1[3];
layout(location = 4, component = 2) out flat float o2[3];
layout(location = 4, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.03125);
    o1[2] = float(0.0625);
    o2[2] = float(0.125);
    o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float o0[3];
layout(location = 1, component = 1) out flat float o1[3];
layout(location = 1, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.03125);
    o1[2] = float(0.0625);
    o2[2] = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float o0[3];
layout(location = 2, component = 1) out flat vec2 o1[3];
layout(location = 2, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.03125);
    o1[2] = vec2(0.0625, 0.125);
    o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat vec2 o0[3];
layout(location = 3, component = 2) out flat float o2[3];
layout(location = 3, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.03125, 0.0625);
    o2[2] = float(0.125);
    o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float o0[3];
layout(location = 4, component = 1) out flat vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float(0.03125);
    o1[2] = vec3(0.0625, 0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat vec3 o0[3];
layout(location = 1, component = 3) out flat float o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec3(0.03125, 0.0625, 0.125);
    o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat vec2 o0[3];
layout(location = 2, component = 2) out flat vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = vec2(0.03125, 0.0625);
    o2[2] = vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat float16_t o1;
layout(location = 3, component = 2) out flat float16_t o2;
layout(location = 3, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.03125);
    o1 = float16_t(0.0625);
    o2 = float16_t(0.125);
    o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0;
layout(location = 4, component = 1) out flat float16_t o1;
layout(location = 4, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.03125);
    o1 = float16_t(0.0625);
    o2 = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat float16_t o0;
layout(location = 1, component = 1) out flat f16vec2 o1;
layout(location = 1, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.03125);
    o1 = f16vec2(0.0625, 0.125);
    o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat f16vec2 o0;
layout(location = 2, component = 2) out flat float16_t o2;
layout(location = 2, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.03125, 0.0625);
    o2 = float16_t(0.125);
    o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0;
layout(location = 3, component = 1) out flat f16vec3 o1;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = float16_t(0.03125);
    o1 = f16vec3(0.0625, 0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec3 o0;
layout(location = 4, component = 3) out flat float16_t o3;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec3(0.03125, 0.0625, 0.125);
    o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0;
layout(location = 1, component = 2) out flat f16vec2 o2;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0 = f16vec2(0.03125, 0.0625);
    o2 = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat float16_t o1[3];
layout(location = 2, component = 2) out flat float16_t o2[3];
layout(location = 2, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.03125);
    o1[2] = float16_t(0.0625);
    o2[2] = float16_t(0.125);
    o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat float16_t o0[3];
layout(location = 3, component = 1) out flat float16_t o1[3];
layout(location = 3, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.03125);
    o1[2] = float16_t(0.0625);
    o2[2] = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat float16_t o0[3];
layout(location = 4, component = 1) out flat f16vec2 o1[3];
layout(location = 4, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.03125);
    o1[2] = f16vec2(0.0625, 0.125);
    o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1, component = 0) out flat f16vec2 o0[3];
layout(location = 1, component = 2) out flat float16_t o2[3];
layout(location = 1, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.03125, 0.0625);
    o2[2] = float16_t(0.125);
    o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2, component = 0) out flat float16_t o0[3];
layout(location = 2, component = 1) out flat f16vec3 o1[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = float16_t(0.03125);
    o1[2] = f16vec3(0.0625, 0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3, component = 0) out flat f16vec3 o0[3];
layout(location = 3, component = 3) out flat float16_t o3[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec3(0.03125, 0.0625, 0.125);
    o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4, component = 0) out flat f16vec2 o0[3];
layout(location = 4, component = 2) out flat f16vec2 o2[3];
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    o0[2] = f16vec2(0.03125, 0.0625);
    o2[2] = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float64_t o0;
    layout(location = 1, component = 2)  flat float64_t o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float64_t(0.03125);
    var_out.o2 = float64_t(0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f64vec2 o0;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f64vec2(0.03125, 0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float64_t o0[3];
    layout(location = 3, component = 2)  flat float64_t o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float64_t(0.03125);
    var_out.o2[2] = float64_t(0.0625);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f64vec2 o0[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f64vec2(0.03125, 0.0625);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat float o1;
    layout(location = 1, component = 2)  flat float o2;
    layout(location = 1, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.03125);
    var_out.o1 = float(0.0625);
    var_out.o2 = float(0.125);
    var_out.o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0;
    layout(location = 2, component = 1)  flat float o1;
    layout(location = 2, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.03125);
    var_out.o1 = float(0.0625);
    var_out.o2 = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float o0;
    layout(location = 3, component = 1)  flat vec2 o1;
    layout(location = 3, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.03125);
    var_out.o1 = vec2(0.0625, 0.125);
    var_out.o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat vec2 o0;
    layout(location = 4, component = 2)  flat float o2;
    layout(location = 4, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.03125, 0.0625);
    var_out.o2 = float(0.125);
    var_out.o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0;
    layout(location = 1, component = 1)  flat vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float(0.03125);
    var_out.o1 = vec3(0.0625, 0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec3 o0;
    layout(location = 2, component = 3)  flat float o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec3(0.03125, 0.0625, 0.125);
    var_out.o3 = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0;
    layout(location = 3, component = 2)  flat vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = vec2(0.03125, 0.0625);
    var_out.o2 = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat float o1[3];
    layout(location = 4, component = 2)  flat float o2[3];
    layout(location = 4, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.03125);
    var_out.o1[2] = float(0.0625);
    var_out.o2[2] = float(0.125);
    var_out.o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float o0[3];
    layout(location = 1, component = 1)  flat float o1[3];
    layout(location = 1, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.03125);
    var_out.o1[2] = float(0.0625);
    var_out.o2[2] = vec2(0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float o0[3];
    layout(location = 2, component = 1)  flat vec2 o1[3];
    layout(location = 2, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.03125);
    var_out.o1[2] = vec2(0.0625, 0.125);
    var_out.o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat vec2 o0[3];
    layout(location = 3, component = 2)  flat float o2[3];
    layout(location = 3, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.03125, 0.0625);
    var_out.o2[2] = float(0.125);
    var_out.o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float o0[3];
    layout(location = 4, component = 1)  flat vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float(0.03125);
    var_out.o1[2] = vec3(0.0625, 0.125, 0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat vec3 o0[3];
    layout(location = 1, component = 3)  flat float o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec3(0.03125, 0.0625, 0.125);
    var_out.o3[2] = float(0.25);
}
#version 450
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat vec2 o0[3];
    layout(location = 2, component = 2)  flat vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = vec2(0.03125, 0.0625);
    var_out.o2[2] = vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat float16_t o1;
    layout(location = 3, component = 2)  flat float16_t o2;
    layout(location = 3, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.03125);
    var_out.o1 = float16_t(0.0625);
    var_out.o2 = float16_t(0.125);
    var_out.o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0;
    layout(location = 4, component = 1)  flat float16_t o1;
    layout(location = 4, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.03125);
    var_out.o1 = float16_t(0.0625);
    var_out.o2 = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat float16_t o0;
    layout(location = 1, component = 1)  flat f16vec2 o1;
    layout(location = 1, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.03125);
    var_out.o1 = f16vec2(0.0625, 0.125);
    var_out.o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat f16vec2 o0;
    layout(location = 2, component = 2)  flat float16_t o2;
    layout(location = 2, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.03125, 0.0625);
    var_out.o2 = float16_t(0.125);
    var_out.o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0;
    layout(location = 3, component = 1)  flat f16vec3 o1;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = float16_t(0.03125);
    var_out.o1 = f16vec3(0.0625, 0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec3 o0;
    layout(location = 4, component = 3)  flat float16_t o3;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec3(0.03125, 0.0625, 0.125);
    var_out.o3 = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0;
    layout(location = 1, component = 2)  flat f16vec2 o2;
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0 = f16vec2(0.03125, 0.0625);
    var_out.o2 = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat float16_t o1[3];
    layout(location = 2, component = 2)  flat float16_t o2[3];
    layout(location = 2, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.03125);
    var_out.o1[2] = float16_t(0.0625);
    var_out.o2[2] = float16_t(0.125);
    var_out.o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat float16_t o0[3];
    layout(location = 3, component = 1)  flat float16_t o1[3];
    layout(location = 3, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.03125);
    var_out.o1[2] = float16_t(0.0625);
    var_out.o2[2] = f16vec2(0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat float16_t o0[3];
    layout(location = 4, component = 1)  flat f16vec2 o1[3];
    layout(location = 4, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.03125);
    var_out.o1[2] = f16vec2(0.0625, 0.125);
    var_out.o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 1) out Out
{
    layout(location = 1, component = 0)  flat f16vec2 o0[3];
    layout(location = 1, component = 2)  flat float16_t o2[3];
    layout(location = 1, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.03125, 0.0625);
    var_out.o2[2] = float16_t(0.125);
    var_out.o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 2) out Out
{
    layout(location = 2, component = 0)  flat float16_t o0[3];
    layout(location = 2, component = 1)  flat f16vec3 o1[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = float16_t(0.03125);
    var_out.o1[2] = f16vec3(0.0625, 0.125, 0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 3) out Out
{
    layout(location = 3, component = 0)  flat f16vec3 o0[3];
    layout(location = 3, component = 3)  flat float16_t o3[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec3(0.03125, 0.0625, 0.125);
    var_out.o3[2] = float16_t(0.25);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in vec4 pos;
layout(location = 4) out Out
{
    layout(location = 4, component = 0)  flat f16vec2 o0[3];
    layout(location = 4, component = 2)  flat f16vec2 o2[3];
}
var_out;
void main()
{
    gl_Position = vec4(pos.xy, 0.0, 1.0);
    var_out.o0[2] = f16vec2(0.03125, 0.0625);
    var_out.o2[2] = f16vec2(0.125, 0.25);
}
