#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec3 color_in[3];
layout(location = 0) smooth out vec3 color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out highp vec3 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec3 color_in;
layout(location = 0) smooth out vec3 color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out highp vec3 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec2 texcoord_in;
layout(location = 0) out vec2 texcoord_out;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    texcoord_out = texcoord_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec3 result = texture(result_sampler, texcoord_in).xyz;
    vec3 ref = texture(ref_sampler, texcoord_in).xyz;
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out highp float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out highp float frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    float result = texture(result_sampler, texcoord_in).x;
    float ref = texture(ref_sampler, texcoord_in).x;
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out highp vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xy;
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out highp vec2 frag_out;
void main()
{
    frag_out = color_in.xy;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec2 result = texture(result_sampler, texcoord_in).xy;
    vec2 ref = texture(ref_sampler, texcoord_in).xy;
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out mediump vec3 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out mediump vec3 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec3 result = texture(result_sampler, texcoord_in).xyz;
    vec3 ref = texture(ref_sampler, texcoord_in).xyz;
    if (distance(result, ref) > 0.1)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out mediump float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out mediump float frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    float result = texture(result_sampler, texcoord_in).x;
    float ref = texture(ref_sampler, texcoord_in).x;
    if (distance(result, ref) > 0.1)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec3 color_in[3];
layout(location = 0) out mediump vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xy;
}
#version 430
layout(location = 0) smooth in vec3 color_in;
layout(location = 0) out mediump vec2 frag_out;
void main()
{
    frag_out = color_in.xy;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec2 result = texture(result_sampler, texcoord_in).xy;
    vec2 ref = texture(ref_sampler, texcoord_in).xy;
    if (distance(result, ref) > 0.1)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in[3];
layout(location = 0) smooth out vec4 color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out highp vec4 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in;
layout(location = 0) smooth out vec4 color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out highp vec4 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec4 result = texture(result_sampler, texcoord_in);
    vec4 ref = texture(ref_sampler, texcoord_in);
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out highp vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xy;
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out highp vec2 frag_out;
void main()
{
    frag_out = color_in.xy;
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out highp vec3 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xyz;
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out highp vec3 frag_out;
void main()
{
    frag_out = color_in.xyz;
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out mediump vec4 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out mediump vec4 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    vec4 result = texture(result_sampler, texcoord_in);
    vec4 ref = texture(ref_sampler, texcoord_in);
    if (distance(result, ref) > 0.1)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out mediump vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xy;
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out mediump vec2 frag_out;
void main()
{
    frag_out = color_in.xy;
}
#version 430
layout(location = 0) smooth in vec4 color_in[3];
layout(location = 0) out mediump vec3 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].xyz;
}
#version 430
layout(location = 0) smooth in vec4 color_in;
layout(location = 0) out mediump vec3 frag_out;
void main()
{
    frag_out = color_in.xyz;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec2 color_in[3];
layout(location = 0) smooth out vec2 color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec2 color_in[3];
layout(location = 0) out highp vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec2 color_in;
layout(location = 0) smooth out vec2 color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) smooth in vec2 color_in;
layout(location = 0) out highp vec2 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) smooth in vec2 color_in[3];
layout(location = 0) out highp float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) smooth in vec2 color_in;
layout(location = 0) out highp float frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) smooth in vec2 color_in[3];
layout(location = 0) out mediump vec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in vec2 color_in;
layout(location = 0) out mediump vec2 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) smooth in vec2 color_in[3];
layout(location = 0) out mediump float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) smooth in vec2 color_in;
layout(location = 0) out mediump float frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in float color_in[3];
layout(location = 0) smooth out float color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in float color_in[3];
layout(location = 0) out highp float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in float color_in;
layout(location = 0) smooth out float color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) smooth in float color_in;
layout(location = 0) out highp float frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) smooth in float color_in[3];
layout(location = 0) out mediump float frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) smooth in float color_in;
layout(location = 0) out mediump float frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in uvec2 color_in[3];
layout(location = 0) flat out uvec2 color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
#version 430
layout(location = 0) flat in uvec2 color_in[3];
layout(location = 0) out highp uvec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in uvec2 color_in;
layout(location = 0) flat out uvec2 color_out;

void main()
{
	gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out highp uvec2 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) usampler2D result_sampler;
uniform layout(set=0, binding=1) usampler2D ref_sampler;
void main()
{
    uvec2 result = texture(result_sampler, texcoord_in).xy;
    uvec2 ref = texture(ref_sampler, texcoord_in).xy;
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) flat in uvec2 color_in[3];
layout(location = 0) out highp uint frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out highp uint frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) usampler2D result_sampler;
uniform layout(set=0, binding=1) usampler2D ref_sampler;
void main()
{
    uint result = texture(result_sampler, texcoord_in).x;
    uint ref = texture(ref_sampler, texcoord_in).x;
    if (result != ref)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) flat in uvec2 color_in[3];
layout(location = 0) out mediump uvec2 frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i];
}
#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out mediump uvec2 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) usampler2D result_sampler;
uniform layout(set=0, binding=1) usampler2D ref_sampler;
void main()
{
    uvec2 result = texture(result_sampler, texcoord_in).xy;
    uvec2 ref = texture(ref_sampler, texcoord_in).xy;
    if (distance(result, ref) > 5)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) flat in uvec2 color_in[3];
layout(location = 0) out mediump uint frag_out[3];
void main()
{
    for (int i = 0; i < 3; i++)
        frag_out[i] = color_in[i].x;
}
#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out mediump uint frag_out;
void main()
{
    frag_out = color_in.x;
}
#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) usampler2D result_sampler;
uniform layout(set=0, binding=1) usampler2D ref_sampler;
void main()
{
    uint result = texture(result_sampler, texcoord_in).x;
    uint ref = texture(ref_sampler, texcoord_in).x;
    if (distance(result, ref) > 5)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in0;
layout(location = 2) in vec4 color_in1;
layout(location = 0) out vec4 color_out0;
layout(location = 1) out vec4 color_out1;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out0 = color_in0;
    color_out1 = color_in1;
}
#version 430
layout(location = 0) in vec4 color_in0;
layout(location = 1) in vec4 color_in1;
layout(location = 0) out vec4 frag_out0;
layout(location = 1) out vec4 frag_out1;
void main()
{
    if (((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2))
    {
        frag_out0 = color_in0;
        frag_out1 = color_in1;
    }
    else
    {
        frag_out0 = color_in1;
        frag_out1 = color_in0;
    }
}
#version 430
layout(location = 0) in vec2 position_in;
void main()
{
    gl_Position = vec4(position_in, 0, 1);
}
#version 430
layout(location = 0) out vec4 frag_out;
void main()
{
    if (((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2))
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) out vec4 frag_out;
void main()
{
    if (((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2))
        frag_out = vec4(0, 1, 0, 1);
    else
        frag_out = vec4(1, 0, 0, 1);
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in0;
layout(location = 2) in uvec2 color_in1;
layout(location = 3) in float color_in2;
layout(location = 0) smooth out vec4 color_out0;
layout(location = 1) flat out uvec2 color_out1;
layout(location = 2) smooth out float color_out2;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out0 = color_in0;
    color_out1 = color_in1;
    color_out2 = color_in2;
}
#version 430
layout(location = 0) smooth in vec4 color_in0;
layout(location = 1) flat in uvec2 color_in1;
layout(location = 2) smooth in float color_in2;
layout(location = 0) out mediump float frag_out0;
layout(location = 1) out lowp uvec2 frag_out1;
layout(location = 2) out highp vec4 frag_out2;
void main()
{
    frag_out0 = color_in2;
    frag_out1 = color_in1;
    frag_out2 = color_in0;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec3 color_in;
layout(location = 0) smooth out vec3 color_out;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in uvec2 color_in;
layout(location = 0) flat out uvec2 color_out;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
#version 430
layout(location = 0) flat in uvec2 color_in;
layout(location = 0) out lowp uvec2 frag_out;
void main()
{
    frag_out = color_in;
}
#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in;
layout(location = 0) smooth out vec4 color_out;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out = color_in;
}
