#version 450

void main ()
{
    switch (gl_VertexIndex) {
        case 0:
            gl_Position = vec4(-3.0, -1.0, 0.0, 1.0);
            break;
        case 1:
            gl_Position = vec4(0.0, 3.0, 0.0, 1.0);
            break;
        case 2:
            gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
            break;
        case 3:
            gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
            break;
        case 4:
            gl_Position = vec4(3.0, -1.0, 0.0, 1.0);
            break;
        case 5:
            gl_Position = vec4(0.0, 3.0, 0.0, 1.0);
            break;
    }
}
#version 450
layout (location=0) out vec4 outColor;

void main ()
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    outColor = (gl_PrimitiveID % 2 == 0) ? red : green;
}
#version 450
layout (vertices = 3) out;

void main ()
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
layout (triangles, equal_spacing, cw) in;

void main ()
{
    gl_Position = gl_in[0].gl_Position * gl_TessCoord.x +
                  gl_in[1].gl_Position * gl_TessCoord.y +
                  gl_in[2].gl_Position * gl_TessCoord.z;
}
#version 450
struct R { vec4 rgba; };
layout(location = 0) out R outColor[3];
void main (void)
{
  outColor[0].rgba = vec4(0.0, 0.9, 0.0, 1.0);
  outColor[1].rgba = vec4(0.3, 0.0, 0.0, 1.0);
  outColor[2].rgba = vec4(0.0, 0.0, 0.6, 1.0);
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.6, 1.0);
}
#version 450
struct R { vec4 rgba; };
layout(location = 0) in R inColor[3];
layout(location = 0) out vec4 color;
void main() {
    color = inColor[2].rgba + inColor[1].rgba + inColor[0].rgba;
}
#version 450
vec2 positions[3] = vec2[](        vec2(-1.0, -1.0),        vec2(3.0, -1.0),        vec2(-1.0, 3.0));
void main() {
        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
#version 450
layout (location=0) out vec4 outColor;
layout(set = 0, binding = 0) uniform Output0 {    uint data;} buf0;
layout(set = 1, binding = 0) uniform Output1 {    uint data;} buf1;
layout(set = 2, binding = 0) uniform Output2 {    uint data;} buf2;

layout(set = 3, binding = 0) uniform Output3 {    uint data;} buf3;
void main ()
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    outColor = ((buf0.data == 0) && (buf1.data == 1) && (buf2.data == 2) && (buf3.data == 3)) ? green : red;
}
#version 450
layout (location=0) out vec4 outColor;
layout(set = 0, binding = 0) uniform Output0 {    uint data;} buf0;
layout(set = 3, binding = 0) uniform Output3 {    uint data;} buf3;
void main ()
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    outColor = ((buf0.data == 0) && (buf3.data == 3)) ? green : red;
}
#version 450
layout(location = 0) out vec2 uv;
void main() {
    uv = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(uv * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location = 0) in vec2 uv;
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D tex;
void main() {
    outColor = texture(tex, uv);
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f);
}
#version 450
vec2 vertices[3];
void main(){
    vertices[0] = vec2(-1.0, -1.0);
    vertices[1] = vec2( 1.0, -1.0);
    vertices[2] = vec2( 0.0,  1.0);
    gl_Position = vec4(vertices[gl_VertexIndex % 3], 0.0, 1.0);
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_scalar_block_layout : require

layout(buffer_reference, buffer_reference_align = 4, scalar) buffer Payload {
    uvec3 payload[];
};

layout(set = 2, binding = 0, std430) buffer SSBO {
    Payload outData[4];
};

layout(set = 0, binding = 0) uniform sampler2D s;
layout(location = 0) out vec4 color;

void main()
{
    outData[0].payload[0] = uvec3(2, 3, 4);
    color = texture(s, vec2(0.0));
}
