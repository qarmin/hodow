#version 450
layout(location = 0) in vec2 vertex_position;

layout(set = 0, binding = 0) buffer block0
{
    int data[20];
} ssbo;

void main()
{
  gl_Position = vec4(vertex_position, 0.0f, 1.0f);

  // Only want to perform these operations once
  if(gl_VertexIndex == 0)
  {
    // Zero constants
    int ival = ssbo.data[0];
    float val = float(ival);

    // int div
    ssbo.data[1] = 7 / ival;
    // float div
    ssbo.data[2] = int(7.0 / val);
    // normalize float
    ssbo.data[3] = int(normalize(val));
    // normalize vec2
    ssbo.data[4] = int(normalize(vec2(val))[ival]);
    // normalize vec3
    ssbo.data[5] = int(normalize(vec3(val))[ival]);
    // normalize vec4
    ssbo.data[6] = int(normalize(vec4(val))[ival]);
    // integer mod
    ssbo.data[7] = 7 % ival;
    // float mod
    ssbo.data[8] = int(mod(7.0, val));
    // vec2 mod
    ssbo.data[9] = int(mod(vec2(7.0), vec2(val))[ival]);
    // vec3 mod
    ssbo.data[10] = int(mod(vec3(7.0), vec3(val))[ival]);
    // vec4 mod
    ssbo.data[11] = int(mod(vec4(7.0), vec4(val))[ival]);
    // float smoothstep
    ssbo.data[12] = int(smoothstep(val, val, 0.3));
    // vec2 smoothstep
    ssbo.data[13] = int(smoothstep(vec2(val), vec2(val), vec2(0.3))[ival]);
    // vec3 smoothstep
    ssbo.data[14] = int(smoothstep(vec3(val), vec3(val), vec3(0.3))[ival]);
    // vec4 smoothstep
    ssbo.data[15] = int(smoothstep(vec4(val), vec4(val), vec4(0.3))[ival]);
    // float atan2
    ssbo.data[16] = int(atan(7.0, val));
    // vec2 atan2
    ssbo.data[17] = int(atan(vec2(7.0), vec2(val))[ival]);
    // vec3 atan2
    ssbo.data[18] = int(atan(vec3(7.0), vec3(val))[ival]);
    // vec4 atan2
    ssbo.data[19] = int(atan(vec4(7.0), vec4(val))[ival]);

    // Known good value
    ssbo.data[0] = 42;
  }
}
#version 450
layout(location = 0) out vec4 color_out;
void main() {
  color_out = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = position;
}
#version 430
layout(location = 0) out vec4 color_out;
void main() {
  ivec4 ifragcoord = ivec4(gl_FragCoord);
  vec4 fragcoord = vec4(ifragcoord);
  // Generate one pixel we can be certain about
  if (ifragcoord.x == 0 && ifragcoord.y == 0)
  {
    color_out = vec4(1.0, 0.0, 0.0, 1.0);
  }
  else
  {
    // Generate sweep of values which hit 0 as divisor.
    // When ifragcoord.y hits 8, the integer case becomes "7 / (8 - 8)"
    switch(ifragcoord.x % 32)
    {
    case 0:
      // int div
      color_out = vec4(7 / (ifragcoord.y - 8), 1.0, 0.0, 1.0);
      break;
    case 1:
      // float div
      color_out = vec4(7 / (fragcoord.y - 8.0), 1.0, 0.0, 1.0);
      break;
    case 2:
      // normalize float
      color_out = vec4(normalize(fragcoord.y - 8.0), 1.0, 0.0, 1.0);
      break;
    case 3:
      // normalize vec2
      color_out = vec4(normalize(fragcoord.yy - vec2(8.0)), 0.0, 1.0);
      break;
    case 4:
      // normalize vec3
      color_out = vec4(normalize(fragcoord.yyy - vec3(8.0)), 1.0);
      break;
    case 5:
      // normalize vec4
      color_out = normalize(fragcoord.yyyy - vec4(8.0));
      break;
    case 6:
      // integer mod
      color_out = vec4((7 % (ifragcoord.y - 8)), 1.0, 0.0, 1.0);
      break;
    case 7:
      // float mod
      color_out = vec4(mod(7.0, (fragcoord.y - 8.0)), 1.0, 0.0, 1.0);
      break;
    case 8:
      // vec2 mod
      color_out = vec4(mod(vec2(7.0), (fragcoord.yy - vec2(8.0))), 0.0, 1.0);
      break;
     case 9:
      // vec3 mod
      color_out = vec4(mod(vec3(7.0), (fragcoord.yyy - vec3(8.0))), 1.0);
      break;
    case 10:
      // vec4 mod
      color_out = mod(vec4(7.0), (fragcoord.yyyy - vec4(8.0)));
      break;
    case 11:
      // float smoothstep
      color_out = vec4(smoothstep(7.0, (fragcoord.y - 8.0), 0.3), 1.0, 0.0, 1.0);
      break;
    case 12:
      // vec2 smoothstep
      color_out = vec4(smoothstep(vec2(7.0), vec2(fragcoord.y - 8.0), vec2(0.3)), 0.0, 1.0);
      break;
    case 13:
      // vec3 smoothstep
      color_out = vec4(smoothstep(vec3(7.0), vec3(fragcoord.y - 8.0), vec3(0.3)), 1.0);
      break;
    case 14:
      // vec4 smoothstep
      color_out = smoothstep(vec4(7.0), vec4(fragcoord.y - 8.0), vec4(0.3));
      break;
    case 15:
      // float atan2
      color_out = vec4(atan(7.0, (fragcoord.y - 8.0)), 1.0, 0.0, 1.0);
      break;
    case 16:
      // vec2 atan2
      color_out = vec4(atan(vec2(7.0), (fragcoord.yy - vec2(8.0))), 0.0, 1.0);
      break;
    case 17:
      // vec3 atan2
      color_out = vec4(atan(vec3(7.0), (fragcoord.yyy - vec3(8.0))), 1.0);
      break;
    case 18:
      // vec4 atan2
      color_out = atan(vec4(7.0), (fragcoord.yyyy - vec4(8.0)));
      break;
    default:
      color_out = vec4(0.0, 0.0, 1.0, 1.0);
    }
  }
}
#version 450

layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;
in gl_PerVertex { vec4 gl_Position; float gl_PointSize; float gl_ClipDistance[]; } gl_in[];

layout(set = 0, binding = 0) buffer block0
{
    int data[20];
} ssbo;

void main(void)
{
  // Only want to perform these operations once
  if(gl_InvocationID == 0)
  {
    // Zero constants
    int ival = ssbo.data[0];
    float val = float(ival);

    // int div
    ssbo.data[1] = 7 / ival;
    // float div
    ssbo.data[2] = int(7.0 / val);
    // normalize float
    ssbo.data[3] = int(normalize(val));
    // normalize vec2
    ssbo.data[4] = int(normalize(vec2(val))[ival]);
    // normalize vec3
    ssbo.data[5] = int(normalize(vec3(val))[ival]);
    // normalize vec4
    ssbo.data[6] = int(normalize(vec4(val))[ival]);
    // integer mod
    ssbo.data[7] = 7 % ival;
    // float mod
    ssbo.data[8] = int(mod(7.0, val));
    // vec2 mod
    ssbo.data[9] = int(mod(vec2(7.0), vec2(val))[ival]);
    // vec3 mod
    ssbo.data[10] = int(mod(vec3(7.0), vec3(val))[ival]);
    // vec4 mod
    ssbo.data[11] = int(mod(vec4(7.0), vec4(val))[ival]);
    // float smoothstep
    ssbo.data[12] = int(smoothstep(val, val, 0.3));
    // vec2 smoothstep
    ssbo.data[13] = int(smoothstep(vec2(val), vec2(val), vec2(0.3))[ival]);
    // vec3 smoothstep
    ssbo.data[14] = int(smoothstep(vec3(val), vec3(val), vec3(0.3))[ival]);
    // vec4 smoothstep
    ssbo.data[15] = int(smoothstep(vec4(val), vec4(val), vec4(0.3))[ival]);
    // float atan2
    ssbo.data[16] = int(atan(7.0, val));
    // vec2 atan2
    ssbo.data[17] = int(atan(vec2(7.0), vec2(val))[ival]);
    // vec3 atan2
    ssbo.data[18] = int(atan(vec3(7.0), vec3(val))[ival]);
    // vec4 atan2
    ssbo.data[19] = int(atan(vec4(7.0), vec4(val))[ival]);

    // Known good value
    ssbo.data[0] = 42;
  }

  gl_Position = gl_in[0].gl_Position;
  EmitVertex();

  gl_Position = gl_in[1].gl_Position;
  EmitVertex();

  gl_Position = gl_in[2].gl_Position;
  EmitVertex();

  EndPrimitive();
}
#version 450

layout (location = 0) out vec4 outColor;

void main(void)
{
  outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450

layout (vertices = 3) out;
in gl_PerVertex { vec4 gl_Position; float gl_PointSize; float gl_ClipDistance[]; } gl_in[gl_MaxPatchVertices];

layout(set = 0, binding = 0) buffer block0
{
    int data[20];
} ssbo;

void main(void)
{
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

  // Only want to perform these operations once
  if(gl_InvocationID == 0)
  {
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;

    // Zero constants
    int ival = ssbo.data[0];
    float val = float(ival);

    // int div
    ssbo.data[1] = 7 / ival;
    // float div
    ssbo.data[2] = int(7.0 / val);
    // normalize float
    ssbo.data[3] = int(normalize(val));
    // normalize vec2
    ssbo.data[4] = int(normalize(vec2(val))[ival]);
    // normalize vec3
    ssbo.data[5] = int(normalize(vec3(val))[ival]);
    // normalize vec4
    ssbo.data[6] = int(normalize(vec4(val))[ival]);
    // integer mod
    ssbo.data[7] = 7 % ival;
    // float mod
    ssbo.data[8] = int(mod(7.0, val));
    // vec2 mod
    ssbo.data[9] = int(mod(vec2(7.0), vec2(val))[ival]);
    // vec3 mod
    ssbo.data[10] = int(mod(vec3(7.0), vec3(val))[ival]);
    // vec4 mod
    ssbo.data[11] = int(mod(vec4(7.0), vec4(val))[ival]);
    // float smoothstep
    ssbo.data[12] = int(smoothstep(val, val, 0.3));
    // vec2 smoothstep
    ssbo.data[13] = int(smoothstep(vec2(val), vec2(val), vec2(0.3))[ival]);
    // vec3 smoothstep
    ssbo.data[14] = int(smoothstep(vec3(val), vec3(val), vec3(0.3))[ival]);
    // vec4 smoothstep
    ssbo.data[15] = int(smoothstep(vec4(val), vec4(val), vec4(0.3))[ival]);
    // float atan2
    ssbo.data[16] = int(atan(7.0, val));
    // vec2 atan2
    ssbo.data[17] = int(atan(vec2(7.0), vec2(val))[ival]);
    // vec3 atan2
    ssbo.data[18] = int(atan(vec3(7.0), vec3(val))[ival]);
    // vec4 atan2
    ssbo.data[19] = int(atan(vec4(7.0), vec4(val))[ival]);

    // Known good value
    ssbo.data[0] = 42;
  }
}
#version 450

layout (triangles, equal_spacing, cw) in;

void main(void)
{
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 450

layout (vertices = 3) out;
in gl_PerVertex { vec4 gl_Position; float gl_PointSize; float gl_ClipDistance[]; } gl_in[gl_MaxPatchVertices];

void main(void)
{
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

  if(gl_InvocationID == 0)
  {
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
  }
}
#version 450

layout (triangles, equal_spacing, cw) in;

layout(set = 0, binding = 0) buffer block0
{
    int data[20];
} ssbo;

void main(void)
{
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  // Only want to perform these operations once
  if(gl_Position.x == 0.5f && gl_Position.y == -0.5f)
  {
    // Zero constants
    int ival = ssbo.data[0];
    float val = float(ival);

    // int div
    ssbo.data[1] = 7 / ival;
    // float div
    ssbo.data[2] = int(7.0 / val);
    // normalize float
    ssbo.data[3] = int(normalize(val));
    // normalize vec2
    ssbo.data[4] = int(normalize(vec2(val))[ival]);
    // normalize vec3
    ssbo.data[5] = int(normalize(vec3(val))[ival]);
    // normalize vec4
    ssbo.data[6] = int(normalize(vec4(val))[ival]);
    // integer mod
    ssbo.data[7] = 7 % ival;
    // float mod
    ssbo.data[8] = int(mod(7.0, val));
    // vec2 mod
    ssbo.data[9] = int(mod(vec2(7.0), vec2(val))[ival]);
    // vec3 mod
    ssbo.data[10] = int(mod(vec3(7.0), vec3(val))[ival]);
    // vec4 mod
    ssbo.data[11] = int(mod(vec4(7.0), vec4(val))[ival]);
    // float smoothstep
    ssbo.data[12] = int(smoothstep(val, val, 0.3));
    // vec2 smoothstep
    ssbo.data[13] = int(smoothstep(vec2(val), vec2(val), vec2(0.3))[ival]);
    // vec3 smoothstep
    ssbo.data[14] = int(smoothstep(vec3(val), vec3(val), vec3(0.3))[ival]);
    // vec4 smoothstep
    ssbo.data[15] = int(smoothstep(vec4(val), vec4(val), vec4(0.3))[ival]);
    // float atan2
    ssbo.data[16] = int(atan(7.0, val));
    // vec2 atan2
    ssbo.data[17] = int(atan(vec2(7.0), vec2(val))[ival]);
    // vec3 atan2
    ssbo.data[18] = int(atan(vec3(7.0), vec3(val))[ival]);
    // vec4 atan2
    ssbo.data[19] = int(atan(vec4(7.0), vec4(val))[ival]);

    // Known good value
    ssbo.data[0] = 42;
  }
}
#version 450

struct Bar {
    uint x;
    uint y;
    uint z[2];
};

layout(set = 0, binding = 0, std430) buffer foo {
    uvec4 a;
    Bar b; // size 16 at offset 16
    uint c;
};

void main() {
    gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
    Bar new_bar = {0, 0, {0, 0}};
    b = new_bar;
}
#version 450

struct Bar {
    uint x;
    uint y;
    uint z[2];
};

layout(set = 0, binding = 0, std430) buffer foo {
    uvec4 a;
    Bar b; // size 16 at offset 16
    uint c;
};

void main() {
    Bar new_bar;
    b = new_bar;
}
#version 430

layout(location = 0) in vec4 position;
layout(location = 1) out vec4 frag_color;

void main() {
  gl_Position = position;
  frag_color = position * 0.5;
}
#version 430
layout(location = 0) out vec4 color_out;
layout(location = 1) in vec4 frag_color;
void main() {
  ivec2 iv = ivec2(frag_color.xy * 256);
  if (((iv.y / 2) & 64) == 64)
    color_out = vec4(1, 0, 0, 1);
  else
    color_out = vec4(0, 1, 1, 1);
}
#version 450
layout(push_constant, std430) uniform PushConstants {
	uint op1;
	uint op2;
} pushConstants;
layout(location=0) out vec4 out_color;
void main()
{
	out_color = vec4(~(pushConstants.op1^pushConstants.op2));
}
