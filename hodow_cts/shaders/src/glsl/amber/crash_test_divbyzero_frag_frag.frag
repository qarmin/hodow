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
